import styles from "./Row1.module.css";
import Image from "next/image";
import graph from "./graph.png";
import Button from "@/components/common/button/Button";
import Card from "@/components/common/card/Card";
import LineChart from "@/components/common/lineChart/LineChart_NoSSR";

export default function Row1() {
  return (
    <div className={styles.section}>
      <Card className={styles.left}>
        <div className={styles.left_top}>
          <div className={styles.left_top_left}>
            <div className={styles.tvl_heading}>Total Value Locked (TVL)</div>
            <div className={styles.tvl_amt}>$6,506,937,559</div>
          </div>
          <div className={styles.left_top_right}>
            <div className={styles.each}>
              <div className={styles.each_heading}>Today</div>
              <div className="red">-2.5%</div>
            </div>
            <div className={styles.each}>
              <div className={styles.each_heading}>7 Days</div>
              <div className="green">+7.5%</div>
            </div>
            <div className={styles.each}>
              <div className={styles.each_heading}>30 Days</div>
              <div className="red">-2.5%</div>
            </div>
          </div>
        </div>
        <div className={styles.bottom}>
          <LineChart />
        </div>
      </Card>
      <div className={styles.right}>
        <div className={styles.right_top}>
          <Button text="Create Fund" />
        </div>
        <Card>
          <div className={styles.right_bottom_top}>
            <span>Fee History</span>
            <div>View All</div>
          </div>
          <div className={styles.fee}>
            <div className={styles.each_fee}>
              <span className={styles.each_fee_detail}>Deposit</span>
              <span className={styles.each_fee_amount + " green"}>
                +$23,738
              </span>
              <span className={styles.each_fee_time}>23-12-2023 06:01 AM</span>
            </div>
            <div className={styles.each_fee}>
              <span className={styles.each_fee_detail}>Deposit</span>
              <span className={styles.each_fee_amount + " green"}>
                +$23,738
              </span>
              <span className={styles.each_fee_time}>23-12-2023 06:01 AM</span>
            </div>
          </div>
        </Card>
      </div>
    </div>
  );
}
