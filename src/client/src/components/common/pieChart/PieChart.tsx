"use client";
import { ResponsivePie } from "@nivo/pie";
export default function PieChart({ data }) {
  const MyResponsivePie = ({ data }) => (
    <ResponsivePie
      tooltip={({ datum }) => {
        return (
          <div
            style={{
              background: "white",
              padding: "9px 12px",
              border: "1px solid #ccc",
              color: "black",
            }}
          >
            <div>x: {datum.label}</div>
            <div>y: {datum.value}</div>
          </div>
        );
      }}
      data={data}
      theme={{
        text: {
          // fontFamily:
          //   "'SFMono-Regular', Consolas, 'Liberation Mono', Menlo, Courier, monospace",
        },
      }}
      margin={{ top: 40, right: 80, bottom: 10, left: 80 }}
      innerRadius={0.5}
      padAngle={0.7}
      cornerRadius={3}
      activeOuterRadiusOffset={8}
      borderWidth={1}
      borderColor={{
        from: "color",
        modifiers: [["darker", 0.2]],
      }}
      arcLinkLabelsSkipAngle={10}
      arcLinkLabelsTextColor="#ffffff"
      arcLinkLabelsThickness={2}
      arcLinkLabelsColor={{ from: "color" }}
      arcLabelsSkipAngle={10}
      arcLabelsTextColor={{
        from: "color",
        modifiers: [["darker", 2]],
      }}
      // legends={[
      //   {
      //     anchor: "bottom",
      //     direction: "column",
      //     justify: true,
      //     translateX: 0,
      //     translateY: 56,
      //     itemsSpacing: 0,
      //     itemWidth: 100,
      //     itemHeight: 18,
      //     itemTextColor: "#999",
      //     itemDirection: "left-to-right",
      //     itemOpacity: 1,
      //     symbolSize: 18,
      //     symbolShape: "circle",
      //     effects: [
      //       {
      //         on: "hover",
      //         style: {
      //           itemTextColor: "white",
      //         },
      //       },
      //     ],
      //   },
      // ]}
    />
  );
  return (
    <div style={{ height: 400 }}>
      <MyResponsivePie data={data} />
    </div>
  );
}
