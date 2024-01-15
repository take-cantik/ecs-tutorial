export default async function Home() {
  const apiUrl = process.env.API_URL as string;
  const res = await fetch(`${apiUrl}/health-check`);
  const text = await res.text();

  return <h1>health-check: {text}</h1>;
}
