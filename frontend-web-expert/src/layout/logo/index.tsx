import { Icon, Title, Description, Outer } from "./style";

type TLogoProps = {
  path: string;
};

function Logo({ path }: TLogoProps) {
  return (
    <Outer to={path}>
      <Icon />
      <Title>약 알</Title>
      <Description>전문가 WEB</Description>
    </Outer>
  );
}

export default Logo;
