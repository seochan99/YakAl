import * as S from "./style.ts";
import React from "react";

type THeaderProps = {
  children?: React.ReactNode;
  to: string;
};

function Header({ children, to }: THeaderProps) {
  return (
    <S.OuterHeader>
      <S.LogoLink to={to}>
        <S.IconImg />
        <S.LogoTextDiv>
          <S.TitleSpan>약 알</S.TitleSpan>
          <S.DescriptionSpan>전문가 WEB</S.DescriptionSpan>
        </S.LogoTextDiv>
      </S.LogoLink>
      {children}
    </S.OuterHeader>
  );
}

export default Header;
