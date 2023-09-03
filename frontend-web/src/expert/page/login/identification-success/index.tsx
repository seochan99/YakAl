import { BigLogo, Description, LogoSection, LogoShade, NextButton } from "./style.ts";

function IdentificationSuccess() {
  return (
    <LogoSection>
      <Description>본인 인증을 성공적으로 마쳤습니다.</Description>
      <BigLogo />
      <LogoShade />
      <NextButton to={"/expert"}>메인 페이지로</NextButton>
    </LogoSection>
  );
}

export default IdentificationSuccess;
