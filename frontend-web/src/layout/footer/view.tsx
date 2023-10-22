import * as S from "./style.ts";
import React from "react";
import { FooterModel } from "../../store/footer_model.ts";

function Footer() {
  const { introductionUrl, name, address, tel, email, businessRegistrationNumber } = FooterModel;

  return (
    <S.OuterFooter>
      <S.IconImg
        onClick={() => {
          window.location.href = introductionUrl;
        }}
      />
      <S.ExplanationParagraph>
        {`${name}`}
        <br />
        {`주소: ${address}  |  전화문의 ${tel}`}
        <br />
        {`E-mail: ${email}  |  사업자등록번호: ${businessRegistrationNumber}호`}
      </S.ExplanationParagraph>
    </S.OuterFooter>
  );
}

export default React.memo(Footer);
