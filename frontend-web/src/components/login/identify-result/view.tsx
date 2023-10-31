import * as S from "./style.ts";
import WarningPage from "../../../page/warning/view.tsx";
import { useLocation } from "react-router-dom";

function IdentifyResultPage() {
  const { state } = useLocation();
  const { isSuccess } = state;

  return (
    <WarningPage
      iconPath={isSuccess ? "/assets/icons/success-icon.png" : "/assets/icons/failure-icon.png"}
      title={isSuccess ? "본인 인증을 성공적으로 마쳤습니다!" : "본인인증 실패"}
      subtitle={isSuccess ? undefined : "본인인증 과정에서 문제가 발생했습니다. 다시 시도해주세요."}
    >
      <S.BackLink to={isSuccess ? "/expert" : "/"}>{isSuccess ? "메인 페이지로" : "로그인 페이지로"}</S.BackLink>
    </WarningPage>
  );
}

export default IdentifyResultPage;
