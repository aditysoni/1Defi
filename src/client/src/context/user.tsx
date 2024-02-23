"use client";
import {
  createContext,
  useContext,
  useEffect,
  useState,
  useCallback,
} from "react";
import { BrowserProvider } from "ethers";
declare var window: any;
interface contextValue {
  user: any;
  utilFunctions: any;
}
const initContextValue: contextValue = {
  user: null,
  utilFunctions: null,
};
const UserContext = createContext(initContextValue);

export default function UserContent({ children }) {
  const [user, setUser] = useState(null);
  const connectToMetamask = useCallback(async () => {
    const provider = new BrowserProvider(window.ethereum);
    let signer = null;
    let address = null;
    let network = null;
    try {
      signer = await provider.getSigner();
      address = await signer.getAddress();
      network = await provider.getNetwork();
    } catch (err) {
      console.log(err);
    }
    setUser({ provider, signer, address, network });
  }, []);
  useEffect(() => {
    window.ethereum?.on("accountsChanged", connectToMetamask);
  }, []);
  const utilFunctions = {
    connectToMetamask,
  };

  return (
    <UserContext.Provider value={{ user, utilFunctions }}>
      {children}
    </UserContext.Provider>
  );
}
// const changeNetwork = async () => {
//   const params = [
//     {
//       chainId: "0x13881",
//       chainName: "Polygon testnet Mumbai",
//       nativeCurrency: {
//         name: "MATIC",
//         symbol: "MATIC",
//         decimals: 18,
//       },
//       rpcUrls: ["https://rpc-mumbai.maticvigil.com"],
//       blockExplorerUrls: ["https://mumbai.polygonscan.com"],
//     },
//   ];

//   window.ethereum
//     .request({
//       id: 1,
//       jsonrpc: "2.0",
//       method: "wallet_addEthereumChain",
//       params,
//     })
//     .then(() => console.log("Success"))
//     .catch((error) => console.log("Error", error.message));
// };

export function useUserContext() {
  return useContext(UserContext);
}
