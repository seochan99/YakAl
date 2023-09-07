import WarningPage from "@/expert/component/warning-page";
import { useState } from "react";
import { Cookies } from "react-cookie";
import { useNavigate } from "react-router-dom";
import { useIdentifyMutation } from "@/expert/api/user.ts";
import { BackButton } from "./style.ts";
import LoadingPage from "@/expert/page/loading-page";
import { useCheckIdentificationQuery } from "@/expert/api/identification.ts";

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
  const navigate = useNavigate();

  const [title, setTitle] = useState<string>("본인인증을 수행해야합니다.");
  const [subtitle, setSubtitle] = useState<string>("아래 버튼을 눌러서 본인인증을 수행해주세요.");

  const [trigger, { isLoading, isError, isSuccess }] = useIdentifyMutation();

  const { data, isError: isCheckError, isLoading: isCkeckLoading } = useCheckIdentificationQuery(null);

  if (isCkeckLoading) {
    return <LoadingPage />;
  }

  if (isCheckError) {
    navigate("/expert/login/identification/failure");
  }

  if (data && data.isIdentified) {
    navigate("/expert");
  }

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
        trigger(response.imp_uid);
      },
    );
  };

  if (isError) {
    navigate("/expert/login/identification/failure");
  }

  if (!isLoading && isSuccess) {
    navigate("/expert/login/identification/success");
  }

  return (
    <WarningPage icon=":)" title={title} subtitle={subtitle}>
      <BackButton onClick={handleIdentificationClick}>본인 인증</BackButton>
    </WarningPage>
  );
}

export default IdentificationPage;
