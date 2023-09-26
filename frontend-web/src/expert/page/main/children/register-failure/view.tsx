import WarningPage from "../../../warning/view.tsx";
import { BackButton } from "./style.ts";

function RegisterFailurePage() {
  return (
    <WarningPage iconPath={"/src/expert/assets/icons/failure-icon.png"} title={"기관 등록 신청에 실패하였습니다."}>
      <BackButton to={"/expert"}>메인으로</BackButton>
    </WarningPage>
  );
}

export default RegisterFailurePage;
