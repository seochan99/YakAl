import WarningPage from "@/expert/component/warning-page";
import { BackButton } from "./style.ts";

function RegistrationFailure() {
  return (
    <WarningPage icon={":("} title={"기관 등록 신청에 실패하였습니다."}>
      <BackButton to={"/expert"}>메인으로</BackButton>
    </WarningPage>
  );
}

export default RegistrationFailure;
