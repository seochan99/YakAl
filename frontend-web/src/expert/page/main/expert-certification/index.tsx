import { BackButton, BackIcon, CertHeader, Outer } from "@/expert/page/main/expert-certification/style.ts";

function ExpertCertification() {
  return (
    <Outer>
      <CertHeader>
        <BackButton to="/expert">
          <BackIcon />
          대시 보드로
        </BackButton>
      </CertHeader>
    </Outer>
  );
}

export default ExpertCertification;
