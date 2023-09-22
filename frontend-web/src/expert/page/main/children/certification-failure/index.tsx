import WarningPage from "../../../warning/view.tsx";
import { BackButton } from "./style.ts";

function CertificationFailure() {
  return (
    <WarningPage iconPath={":("} title={"전문가 인증 신청에 실패하였습니다."}>
      <BackButton to={"/expert"}>메인으로</BackButton>
    </WarningPage>
  );
}

export default CertificationFailure;
