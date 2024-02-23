import Drawer from "@/components/common/drawer/Drawer";
import styles from "./page.module.css";
import Navbar from "@/components/common/navbar/Navbar";
import Row1 from "@/components/managerDashboard/Row1/Row1";
import Row2 from "@/components/managerDashboard/Row2/Row2";
import Row3 from "@/components/managerDashboard/Row3/Row3";

export default function Manager() {
  return (
    <div className={styles.main}>
      <Navbar />
      <div className={styles.content}>
        <Drawer />
        <div className={styles.right}>
          <Row1 />
          <Row2 />
          <Row3 />
        </div>
      </div>
    </div>
  );
}
