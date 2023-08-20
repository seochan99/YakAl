import { Outer, Text } from "./style";

type TPatientInfoTextProps = {
  text: string;
};

function PatientInfoText({ text }: TPatientInfoTextProps) {
  return (
    <Outer>
      <Text>{text}</Text>
    </Outer>
  );
}

export default PatientInfoText;
