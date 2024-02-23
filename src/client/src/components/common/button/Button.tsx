import styles from "./Button.module.css";

export default function Button(props) {
  return (
    <div>
      <button onClick={props.onClick} className={styles.button}>
        {props.text}
      </button>
    </div>
  );
}
