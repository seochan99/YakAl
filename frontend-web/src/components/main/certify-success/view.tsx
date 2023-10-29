import WarningPage from "../../../page/warning/view.tsx";
import * as S from "./style.ts";

function CertificationSuccess() {
  return (
    <WarningPage iconPath={":)"} title={"전문가 인증 신청에 성공하였습니다."}>
      <S.BackLink to={"/expert"}>메인으로</S.BackLink>
    </WarningPage>
  );
}

export default CertificationSuccess;
