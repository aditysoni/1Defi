"use client";
import dynamic from "next/dynamic";
import { ResponsiveContainer } from "recharts";
import {
  AreaChart,
  Area,
  XAxis,
  YAxis,
  CartesianGrid,
  Tooltip,
} from "recharts";

const data = [
  {
    name: "Page A",
    uv: 4000,
  },
  {
    name: "Page B",
    uv: 3000,
  },
  {
    name: "Page C",
    uv: 2000,
  },
  {
    name: "Page D",
    uv: 2780,
  },
  {
    name: "Page E",
    uv: 1890,
  },
];

const renderCustomAxisTick = ({ x, y, payload }) => {
  let text = "";
  let textColor = "red"; // Change color as needed

  switch (payload.value) {
    case "Page A":
      text = "A";
      break;
    case "Page B":
      text = "B";
      break;
    default:
      text = "";
  }

  return (
    <text
      x={x}
      y={y}
      dy={16} // Adjust as needed to position the text correctly
      textAnchor="middle"
      fill={textColor}
    >
      {text}
    </text>
  );
};

function getIntroOfPage(label) {
  // if (label === 'Page A') {
  //   return 'Page A is about men's clothing';
  // } if (label === 'Page B') {
  //   return 'Page B is about women's dress';
  // } if (label === 'Page C') {
  //   return 'Page C is about women's bag';
  // } if (label === 'Page D') {
  //   return 'Page D is about household goods';
  // } if (label === 'Page E') {
  //   return 'Page E is about food';
  // } if (label === 'Page F') {
  //   return 'Page F is about baby food';
  // }
  return "shit!!";
}
const CustomTooltip = function CustomTooltip(props) {
  if (props.active && props.payload) {
    console.log(props);
    const { payload, label, active } = props;
    return (
      <div
        style={{
          background: "white",
          padding: "9px 12px",
          border: "1px solid #ccc",
          color: "black",
        }}
        className="custom-tooltip"
      >
        <p className="label">{`${label} : ${payload[0].value}`}</p>
        {/* <p className="intro">{getIntroOfPage(label)}</p>
        <p className="desc">Anything you want can be displayed here.</p> */}
      </div>
    );
  }

  return null;
};
export default function LineChart1() {
  return (
    <ResponsiveContainer width="100%" height="100%">
      <AreaChart
        id="test"
        data={data}
        margin={{
          top: 0,
          right: 0,
          left: 0,
          bottom: 0,
        }}
      >
        <defs>
          <linearGradient
            id="orangeGradient"
            x1="0%"
            y1="0%"
            x2="100%"
            y2="100%"
          >
            <stop
              offset="0%"
              style={{ stopColor: "rgba(253, 121, 19, 0.06)", stopOpacity: 1 }}
            />
            <stop
              offset="100%"
              style={{ stopColor: "rgba(0, 0, 0, 0.22)", stopOpacity: 1 }}
            />
          </linearGradient>
        </defs>
        {/* <CartesianGrid strokeDasharray="3 3" /> */}
        {/* <XAxis dataKey="name" tick={renderCustomAxisTick} /> */}
        {/* <YAxis /> */}
        <Tooltip
          content={({ active, payload, label }) => (
            <CustomTooltip active={active} payload={payload} label={label} />
          )}
        />
        <Area
          type="monotone"
          dataKey="uv"
          strokeWidth="3"
          fill="url(#orangeGradient)"
          stroke="#FD7913"
        />
      </AreaChart>
    </ResponsiveContainer>
  );
}

// const NoSSR = dynamic(() => LineChart1, { ssr: false });

// export default function Page() {
//   return (
//     <div>
//       <NoSSR />
//     </div>
//   );
// }
