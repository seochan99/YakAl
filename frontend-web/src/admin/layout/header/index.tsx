import { LinkLogo, LogoText, Outer, Subtitle, Title, YakalIcon } from "./style.ts";
import React from "react";

type THeaderProps = {
  children?: React.ReactNode;
  to: string;
};

function Header({ children, to }: THeaderProps) {
  return (
    <Outer>
      <LinkLogo to={to}>
        <YakalIcon />
        <LogoText>
          <Title>약 알</Title>
          <Subtitle>관리자 WEB</Subtitle>
        </LogoText>
      </LinkLogo>
      {children}
    </Outer>
  );
}

export default Header;
