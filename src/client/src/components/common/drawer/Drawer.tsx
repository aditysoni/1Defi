"use client";
import styles from "./Drawer.module.css";
import { usePathname } from "next/navigation";

import Link from "next/link";
export default function Drawer() {
  const pathname = usePathname();
  return (
    <div className={styles.main}>
      <div className={styles.menu}>
        <Link
          className={
            styles.link + (pathname == "/overview" ? ` ${styles.active}` : "")
          }
          href="/overview"
        >
          <span>Overview</span>
        </Link>
        <Link
          className={
            styles.link +
            (pathname == "/managerDashboard" ? ` ${styles.active}` : "")
          }
          href="/managerDashboard"
        >
          <span>Manager Dashboard</span>
        </Link>
        <Link
          className={
            styles.link +
            (pathname == "/investorDashboard" ? ` ${styles.active}` : "")
          }
          href="/investorDashboard"
        >
          <span>Investor Dashboard</span>
        </Link>
        <Link
          className={
            styles.link + (pathname == "/help" ? ` ${styles.active}` : "")
          }
          href="/help"
        >
          <span>Help</span>
        </Link>
      </div>
    </div>
  );
}
