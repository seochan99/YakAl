import { Description, HeaderOuter, Icon, LogoOuter, LogoText, Title } from "./style";

type THeaderProps = {
  children?: React.ReactNode;
  to: string;
};

function Header({ children, to }: THeaderProps) {
  return (
    <HeaderOuter>
      <LogoOuter to={to}>
        <Icon />
        <LogoText>
          <Title>약 알</Title>
          <Description>전문가 WEB</Description>
        </LogoText>
      </LogoOuter>
      {children}
    </HeaderOuter>
  );
}

export default Header;
