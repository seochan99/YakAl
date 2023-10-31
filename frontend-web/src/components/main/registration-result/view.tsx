import WarningPage from "../../../page/warning/view.tsx";
import { BackButton } from "./style.ts";
import { useLocation } from "react-router-dom";

function RegistrationResultPage() {
  const { state } = useLocation();
  const { isSuccess } = state;

  return (
    <WarningPage
      iconPath={isSuccess ? "/assets/icons/success-icon.png" : "/assets/icons/failure-icon.png"}
      title={isSuccess ? "기관 등록 신청에 성공하였습니다." : "기관 등록 신청에 실패하였습니다."}
    >
      <BackButton to={"/expert"}>메인으로</BackButton>
    </WarningPage>
  );
}

export default RegistrationResultPage;
