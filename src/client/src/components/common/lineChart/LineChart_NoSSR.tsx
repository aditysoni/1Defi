import dynamic from "next/dynamic";

const NoSSR = dynamic(() => import("./LineChart"), { ssr: false });

export default function Page() {
  return <NoSSR />;
}
