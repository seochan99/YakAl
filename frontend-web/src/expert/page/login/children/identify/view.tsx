import WarningPage from "../../../warning/view.tsx";
import { useState } from "react";
import { Cookies } from "react-cookie";
import { BackButton } from "./style.ts";

type TIdResponse = {
  error_code: string | null;
  error_msg: string | null;
  imp_uid: string;
  merchant_uid: string;
  pg_provider: string;
  pg_type: string;
  success: boolean;
};

function IdentifyPage() {
  const [title, setTitle] = useState<string>("본인인증을 수행해야합니다.");
  const [subtitle, setSubtitle] = useState<string>("아래 버튼을 눌러서 본인인증을 수행해주세요.");

  const handleIdentificationClick = () => {
    setSubtitle("");
    setTitle("본인인증 수행 중");

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
        console.log(response);
      },
    );
  };

  return (
    <WarningPage iconPath=":)" title={title} subtitle={subtitle}>
      <BackButton onClick={handleIdentificationClick}>본인 인증</BackButton>
    </WarningPage>
  );
}

export default IdentifyPage;
