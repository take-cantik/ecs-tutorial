const getHealthCheck = async () => {
  const apiUrl = process.env.API_URL as string;
  const res = await fetch(`${apiUrl}/health-check`);
  const text = await res.text();
  return text;
}

export default async function Home() {
  const text = await getHealthCheck();

  return <h1>health-check: {text}</h1>;
}
