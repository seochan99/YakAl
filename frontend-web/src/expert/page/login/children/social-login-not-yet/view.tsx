import WarningPage from "../../../warning/view.tsx";
import * as S from "./style.ts";

function SocialLoginNotYetPage() {
  return (
    <WarningPage
      iconPath="/src/expert/assets/icons/no-entry-icon.png"
      title="소셜 로그인 오류"
      description={
        <>
          소셜 로그인이 완료되지 않아 본인인증을 진행할 수 없습니다.
          <br />
          소셜 로그인을 다시 시도해주세요.
        </>
      }
    >
      <S.BackLink to="/expert/login">로그인 메인 페이지로</S.BackLink>
    </WarningPage>
  );
}

export default SocialLoginNotYetPage;
