"use client";
import Image from "next/image";
import styles from "./page.module.css";
import { useUserContext } from "../context/user";
import { useEffect, useState } from "react";
import axios from "axios";

export default function Home(): JSX.Element {
  const { user, utilFunctions } = useUserContext();
  useEffect(() => {
    utilFunctions.connectToMetamask();
  }, []);

  // useEffect(() => {
  //   const init = async () => {
  //     if (user && user.provider) {
  //       const res = await user.provider.getBalance(
  //         "0x994196D09bbca75C1Ba4f99762b1D97f768cB4d1"
  //       );

  //       console.log(res);
  //       const res2 = await user.provider.getNetwork();
  //       const res3 = JSON.stringify(res2);
  //       console.log(res2.name);
  //       console.log(await user.signer.getAddress());
  //       // const res3 = await user.provider.getCode();
  //       // console.log(res3);
  //     }

  //     // await connectToMetamask();
  //   };
  //   // init();
  // }, [user]);

  // useEffect(() => {
  //   const fetchData = async () => {
  //     const endpoint =
  //       "https://api.studio.thegraph.com/query/61262/vj_test/version/latest";

  //     const query = gql`
  //       {
  //         deposits(first: 5) {
  //           id
  //           depositor
  //           amount
  //           blockNumber
  //         }
  //         withdrawals(first: 5) {
  //           id
  //           recipient
  //           amount
  //           blockNumber
  //         }
  //       }
  //     `;

  //     try {
  //       const response = await axios({
  //         url: "https://api.studio.thegraph.com/query/61262/vj_test/version/latest",
  //         method: "post",
  //         data: {
  //           query: `
  //             query {
  //               deposits(first: 5) {
  //                 id
  //                 depositor
  //                 amount
  //                 blockNumber
  //               }
  //               withdrawals(first: 5) {
  //                 id
  //                 recipient
  //                 amount
  //                 blockNumber
  //               }
  //             }
  //           `,
  //         },
  //       }).then((result) => {
  //         console.log(result);
  //       });
  //     } catch (error) {
  //       console.error("Error:", error);
  //     }
  //   };

  //   fetchData();
  // }, []); // Empty dependency array means this effect runs once after the initial render
  // if (user && user.provider) {
  //   console.log(user.address);
  //   console.log(user.provider.getCode(user.address));
  // }
  console.log(user);
  return (
    <div>
      <button onClick={utilFunctions.connectToMetamask}>
        connectToMetamask
      </button>
      <div>{user && user.address}</div>
      <div>{user && user.network.name}</div>
    </div>
  );
}
