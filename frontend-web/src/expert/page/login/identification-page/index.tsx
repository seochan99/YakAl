// import cryptoJs from "crypto-js";
// import axios, { isAxiosError } from "axios";

// import getCrypto from "@/util/get-crypto";
import WarningPage from "@/expert/component/warning-page";
import useInterval from "@/expert/util/use-interval.ts";
import { useEffect, useState } from "react";
import { Cookies } from "react-cookie";
import { useNavigate } from "react-router-dom";
import { useIdentifyMutation } from "@/expert/api/user.ts";

type TIdResponse = {
  error_code: string | null;
  error_msg: string | null;
  imp_uid: string;
  merchant_uid: string;
  pg_provider: string;
  pg_type: string;
  success: boolean;
};

function IdentificationPage() {
  const [dotString, setDotString] = useState<string>(".");

  const [trigger, { isLoading, isError, isSuccess }] = useIdentifyMutation();

  const navigate = useNavigate();

  useInterval(() => {
    setDotString(dotString === "..." ? "." : dotString.concat("."));
  }, 1000);

  useEffect(() => {
    const cookies = new Cookies();
    cookies.remove("accessToken", { path: "/" });

    const IMP = window.IMP;
    IMP.init(`${import.meta.env.VITE_MERCHANDISE_ID}`);

    IMP.certification(
      {
        merchant_uid: `mid_${Date.now().toString()}`,
        popup: true,
      },
      (response: TIdResponse) => {
        trigger(response.imp_uid);
      },
    );
  }, [trigger]);

  if (isError) {
    navigate("/expert/login/identification/failure");
  }

  if (!isLoading && isSuccess) {
    navigate("/expert/login/identification/success");
  }

  return (
    <WarningPage icon=":|" title={`본인 인증 중${dotString}`} subtitle="본인 인증 중입니다. 잠시만 기다려주세요." />
  );
}

export default IdentificationPage;
