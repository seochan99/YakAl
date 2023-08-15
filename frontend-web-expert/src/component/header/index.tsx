import { Description, OuterDiv, Title } from "./style";

type HeaderProps = {
  title: string;
  description: string;
};

export default function Header({ title, description }: HeaderProps) {
  return (
    <OuterDiv>
      <Title>{title}</Title>
      <Description>{description}</Description>
    </OuterDiv>
  );
}
