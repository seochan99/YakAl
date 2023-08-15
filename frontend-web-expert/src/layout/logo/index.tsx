import { Icon, Title, Description, Outer, NonBorderOuter } from "./style";

type TLogoProps = {
  hasBorder: boolean;
  path: string;
};

function Logo({ hasBorder, path }: TLogoProps) {
  const Wrapper = hasBorder ? Outer : NonBorderOuter;

  return (
    <Wrapper to={path}>
      <Icon />
      <Title>약 알</Title>
      <Description>전문가 WEB</Description>
    </Wrapper>
  );
}

export default Logo;
