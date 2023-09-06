import { useLoaderData } from "react-router-dom";
import { TFacilityRegistrationInfoLoaderReturn } from "./loader.ts";
import ErrorPage from "../../../../expert/page/error-page";
import { BackButton, BackIcon, FacilityMain, Header, Outer } from "./style.ts";

function FacilityRegistrationInfo() {
  const { facilityInfo } = useLoaderData() as TFacilityRegistrationInfoLoaderReturn;

  if (!facilityInfo) {
    return <ErrorPage />;
  }

  return (
    <Outer>
      <Header>
        <BackButton to="/admin/partner/facility-registration">
          <BackIcon />
          기관 목록으로
        </BackButton>
      </Header>
      <FacilityMain></FacilityMain>
    </Outer>
  );
}

export default FacilityRegistrationInfo;
