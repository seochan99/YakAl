// import cryptoJs from "crypto-js";
// import axios, { isAxiosError } from "axios";

// import getCrypto from "@/util/get-crypto";
import WarningPage from "@/expert/component/warning-page";
import useInterval from "@/expert/util/use-interval.ts";
import { useEffect, useState } from "react";
import { Cookies } from "react-cookie";
import { useNavigate } from "react-router-dom";

function IdentificationPage() {
  const [dotString, setDotString] = useState<string>(".");

  const navigate = useNavigate();

  useInterval(() => {
    setDotString(dotString === "..." ? "." : dotString.concat("."));
  }, 1000);

  useEffect(() => {
    const cookies = new Cookies();
    cookies.remove("accessToken", { path: "/" });

    // const mTxId = new Int8Array(20);
    // getCrypto().getRandomValues(mTxId);

    // const authHash = cryptoJs
    //   .SHA256(import.meta.env.VITE_IDENTIFICATION_MID + mTxId.toString() + import.meta.env.VITE_IDENTIFICATION_API_KEY)
    //   .toString()
    //   .toLowerCase();

    // axios
    //   .post(
    //     `${import.meta.env.VITE_IDENTIFICATION_HOST}`,
    //     {
    //       mid: import.meta.env.VITE_IDENTIFICATION_MID, // 상점 아이디
    //       reqSvcCd: "01", // 간편 인증
    //       mTxId, // 가맹점 트랜젝션 ID
    //       successUrl: `${import.meta.env.VITE_FRONTEND_HOST}/login/identification/success`, // 인증 성공 결과 수신 URL
    //       failUrl: `${import.meta.env.VITE_FRONTEND_HOST}/login/identification/failure`, // 인증 실패 결과 수신 URL
    //       authHash, // mid + mTxId + apikey -> SHA256
    //       flgFixedUser: "N", // 특정 사용자에게 인증 요청 여부: No
    //       reservedMsg: "isUseToken=Y", // 개인 정보 암호화 사용 요청
    //     },
    //     {
    //       headers: { "Content-Type": "application/x-www-form-urlencoded;charset=utf-8" },
    //     },
    //   )
    //   .then((response) => {
    //     console.log("success");

    //     const { resultCode, authRequestUrl, txId, token } = response.data as {
    //       resultCode: string;
    //       resultMsg: string;
    //       authRequestUrl: string;
    //       txId: string;
    //       token: string;
    //     };

    //     if (resultCode !== "0000") {
    //       //navigate("/expert/login/identification/failure");
    //     }

    //     window.open(response.headers.location, "_blank");

    //     console.log(resultCode, authRequestUrl, txId, token);
    //   })
    //   .catch((error) => {
    //     console.log(error);

    //     if (isAxiosError(error)) {
    //       //navigate("/expert/login/identification/failure");
    //     }
    //   });

    navigate("/expert");
  }, [navigate]);

  return (
    <WarningPage icon=":|" title={`본인 인증 중${dotString}`} subtitle="본인 인증 중입니다. 잠시만 기다려주세요." />
  );
}

export default IdentificationPage;
