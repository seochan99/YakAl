import WarningPage from "../../../warning/view.tsx";
import * as S from "./style.ts";

function CertifyFailurePage() {
  return (
    <WarningPage iconPath={":("} title={"전문가 인증 신청에 실패하였습니다."}>
      <S.BackLink to={"/expert"}>메인으로</S.BackLink>
    </WarningPage>
  );
}

export default CertifyFailurePage;
