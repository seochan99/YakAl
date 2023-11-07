import WarningPage from "@page/warning/view.tsx";
import * as S from "./style.ts";
import { useIdentifyPageViewController } from "./view.controller.ts";
import LoadingSpinner from "@components/loading-spinner/view.tsx";

function IdentifyPage() {
  const { onIdentificationClick, isLoading } = useIdentifyPageViewController();

  return (
    <WarningPage
      iconPath={"/assets/icons/identify-icon.png"}
      title={"본인인증을 수행해야합니다."}
      subtitle={"아래 버튼을 눌러서 본인인증을 수행해주세요."}
    >
      <S.ButtonDiv onClick={onIdentificationClick}>{"본인 인증"}</S.ButtonDiv>
      {isLoading && <LoadingSpinner />}
    </WarningPage>
  );
}

export default IdentifyPage;
