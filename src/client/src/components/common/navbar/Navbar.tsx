import styles from "./Navbar.module.css";
import downSvg from "@public/assets/icons/down2.svg";
import chainSvg from "@public/assets/icons/chain.svg";
import Image from "next/image";

export default function Navbar() {
  return (
    <div className={styles.main}>
      <div className={styles.logo}>1DeFi</div>
      <div className={styles.wallet_container}>
        <div className={styles.wallet_address}>
          <span>0x3B....FbD2</span>
          <Image src={downSvg} alt="down" />
        </div>
        <div className={styles.chain_container}>
          <Image src={chainSvg} alt="down" />
        </div>
      </div>
    </div>
  );
}
