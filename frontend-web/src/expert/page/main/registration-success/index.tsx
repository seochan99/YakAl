import WarningPage from "../../../../expert/component/warning-page/index.tsx";
import { BackButton } from "./style.ts";

function RegistrationSuccess() {
  return (
    <WarningPage icon={":)"} title={"기관 등록 신청에 성공하였습니다."}>
      <BackButton to={"/expert"}>메인으로</BackButton>
    </WarningPage>
  );
}

export default RegistrationSuccess;
