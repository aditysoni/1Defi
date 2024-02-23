import Button from "@/components/common/button/Button";
import styles from "./Row3.module.css";
import Card from "@/components/common/card/Card";

export default function Row3() {
  return (
    <Card className={styles.section}>
      <div className={styles.header}>
        <div className={styles.heading}>Funds List</div>
        <Button text="Add Fund" />
      </div>
      <table className={styles.table}>
        <thead>
          <tr>
            <th>S.No</th>
            <th>Fund Name</th>
            <th>TVL</th>
            <th>Type</th>
            <th>Fee Collected</th>
            <th>24h P&L</th>
            <th>Actions</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>1.</td>
            <td className={styles.type_text}>Parag Parikh Flexi Cap Fund</td>
            <td>$23,738</td>
            <td className={styles.type_text}>Private</td>
            <td>$23,738</td>
            <td className="red">-23.7%</td>
            <td>
              <Button text="View" />
            </td>
          </tr>
        </tbody>
      </table>
    </Card>
  );
}
