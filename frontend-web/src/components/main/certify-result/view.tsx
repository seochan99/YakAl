import WarningPage from "@page/warning/view.tsx";
import * as S from "./style.ts";
import { useLocation } from "react-router-dom";

function CertifyResultPage() {
  const { state } = useLocation(); // 2번 라인
  const { isSuccess } = state;

  return (
    <WarningPage
      iconPath={isSuccess ? "/assets/icons/success-icon.png" : "/assets/icons/failure-icon.png"}
      title={isSuccess ? "전문가 인증 신청에 성공하였습니다." : "전문가 인증 신청에 실패하였습니다."}
    >
      <S.BackLink to={"/expert"}>메인으로</S.BackLink>
    </WarningPage>
  );
}

export default CertifyResultPage;
