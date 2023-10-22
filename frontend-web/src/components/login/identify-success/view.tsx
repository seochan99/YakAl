import * as S from "./style.ts";
import WarningPage from "../../../warning/view.tsx";

function IdentifySuccessPage() {
  return (
    <WarningPage iconPath={"/src/expert/assets/icons/success-icon.png"} title={"본인 인증을 성공적으로 마쳤습니다!"}>
      <S.NextLink to={"/expert"}>메인 페이지로</S.NextLink>
    </WarningPage>
  );
}

export default IdentifySuccessPage;
