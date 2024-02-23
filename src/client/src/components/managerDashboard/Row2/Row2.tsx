"use client";
import styles from "./Row2.module.css";
import Image from "next/image";
import chart from "./chart.png";
import gainSvg from "@public/assets/icons/gain.svg";
import lossSvg from "@public/assets/icons/loss.svg";
import fundChart from "./fund_chart.png";
import PieChart from "@/components/common/pieChart/PieChart";
import Card from "@/components/common/card/Card";

export default function Row2() {
  const data = [
    {
      id: "javascript",
      label: "javascript",
      value: 365,
      // color: "hsl(164, 70%, 50%)",
    },
    {
      id: "python",
      label: "python",
      value: 471,
      // color: "hsl(216, 70%, 50%)",
    },
    {
      id: "rust",
      label: "rust",
      value: 351,
      // color: "hsl(357, 70%, 50%)",
    },
    {
      id: "make",
      label: "make",
      value: 402,
      // color: "hsl(345, 70%, 50%)",
    },
    {
      id: "111",
      label: "11",
      value: 3413,
      // color: "hsl(12, 70%, 50%)",
    },
  ];
  return (
    <div className={styles.section}>
      <Card className={styles.left}>
        <div className={styles.left_heading}>Fund Allocation</div>
        <PieChart data={data} />
      </Card>
      <div className={styles.right}>
        <Card className={styles.fund_leaderboard}>
          <div className={styles.fund_leaderboard_top}>
            <div className={styles.fund_leaderboard_icon}>
              <Image src={gainSvg} alt="gain" />
            </div>
            <span>DeFi Funds</span>
          </div>
          <div className={styles.fund_leaderboard_value}>$23,756</div>
          <div className={styles.fund_chart}>
            <Image src={fundChart} alt="fundChart" />
          </div>
          <div className={styles.fund_pnl}>
            <div className={styles.fund_pnl_heading}>P&L Daily</div>
            <div className={styles.fund_pnl_dollar + " green"}>+25$</div>
            <div className={styles.fund_pnl_percentage + " green"}>+2.5%</div>
          </div>
        </Card>
        <Card className={styles.fund_leaderboard}>
          <div className={styles.fund_leaderboard_top}>
            <div className={styles.fund_leaderboard_icon}>
              <Image src={lossSvg} alt="gain" />
            </div>
            <span>Pandya Funds</span>
          </div>
          <div className={styles.fund_leaderboard_value}>$23,756</div>
          <div className={styles.fund_chart}>
            <Image src={fundChart} alt="fundChart" />
          </div>
          <div className={styles.fund_pnl}>
            <div className={styles.fund_pnl_heading}>P&L Daily</div>
            <div className={styles.fund_pnl_dollar + " green"}>+25$</div>
            <div className={styles.fund_pnl_percentage + " green"}>+2.5%</div>
          </div>
        </Card>
      </div>
    </div>
  );
}
