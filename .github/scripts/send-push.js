const { initializeApp, cert } = require('firebase-admin/app');
const { getMessaging } = require('firebase-admin/messaging');


initializeApp({
  credential:  cert(JSON.parse(process.env.FIREBASE_SERVICE_ACCOUNT)),
});


const BASE = 'https://feed.evangelizo.org/v2/reader.php';
const MAX_BODY = 400; 
function today() {
  return new Intl.DateTimeFormat('en-CA', {
    timeZone: 'America/Managua',
    year: 'numeric',
    month: '2-digit',
    day: '2-digit',
  })
    .format(new Date())
    .replaceAll('-', '');
}


function clean(text) {
  return text
    .replace(/<br\s*\/?>/gi, ' ')
    .replace(/<[^>]*>/g, '')
    .replace(/&nbsp;/g, ' ')
    .replace(/&amp;/g, '&')
    .replace(/&quot;/g, '"')
    .replace(/&#0?39;/g, "'")
    .replace(/\s+/g, ' ')
    .trim();
}

function truncate(text, max) {
  return text.length <= max ? text : text.slice(0, max).trimEnd() + '…';
}

async function evangelizo(type, date) {
  const url = `${BASE}?date=${date}&type=${type}&lang=SP&content=GSP`;
  const res = await fetch(url);
  if (!res.ok) throw new Error(`Evangelizo ${type}: HTTP ${res.status}`);
  const raw = await res.text();

  // El texto real termina en el primer <br /><br />; después viene el pie de página
  const [main] = raw.split(/<br\s*\/?>\s*<br\s*\/?>/i);
  return clean(main);
}

async function main() {
  const date = today();

  const [ref, text] = await Promise.all([
    evangelizo('reading_st', date),
    evangelizo('reading', date),
  ]);

  if (!text) throw new Error('La API devolvió un texto vacío');

  const reference = ref.replace(/\.$/, ''); // "Lc 10,38-42." -> "Lc 10,38-42"
  const title = reference ? `Evangelio del día: ${reference}` : 'Evangelio del día';

  const id = await getMessaging().send({
    topic: 'todos',
    notification: {
      title,
      body: truncate(text, MAX_BODY),
    },
    data: { tipo: 'evangelio', fecha: date },
  });

  console.log('Enviado:', id);
}

main().catch((e) => {
  console.error(e);
  process.exit(1);
});