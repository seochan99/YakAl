import WarningPage from "../../../warning/view.tsx";
import { BackButton } from "./style.ts";

function RegisterSuccessPage() {
  return (
    <WarningPage iconPath={"/src/expert/assets/icons/success-icon.png"} title={"기관 등록 신청에 성공하였습니다."}>
      <BackButton to={"/expert"}>메인으로</BackButton>
    </WarningPage>
  );
}

export default RegisterSuccessPage;
