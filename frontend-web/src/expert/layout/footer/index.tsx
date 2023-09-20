import * as S from "./style.ts";

function Footer() {
  const viewPharmInfo = {
    introductionUrl: "https://viewpharm1.oopy.io/",
    name: "VIEW PHARM (뷰팜)",
    address: "충청북도 청주시 흥덕구 오송읍 오송생명3로 31",
    tel: "010-9229-9531",
    email: "Viewpharm1@gmail.com",
    businessRegistrationNumber: "220-87-17483",
  };

  return (
    <S.OuterFooter>
      <S.IconImg
        onClick={() => {
          window.location.href = viewPharmInfo.introductionUrl;
        }}
      />
      <S.ExplanationParagraph>
        {`${viewPharmInfo.name}`}
        <br />
        {`주소: ${viewPharmInfo.address}  |  전화문의 ${viewPharmInfo.tel}`}
        <br />
        {`E-mail: ${viewPharmInfo.email}  |  사업자등록번호: ${viewPharmInfo.businessRegistrationNumber}호`}
      </S.ExplanationParagraph>
    </S.OuterFooter>
  );
}

export default Footer;
