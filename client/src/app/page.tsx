export default async function Home() {
  const res = await fetch("http://localhost/api/health-check");
  const text = await res.text();

  return <h1>health-check: {text}</h1>;
}
