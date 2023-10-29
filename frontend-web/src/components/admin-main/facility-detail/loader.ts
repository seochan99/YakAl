import { LoaderFunctionArgs } from "react-router-dom";

export function loader({ params }: LoaderFunctionArgs): number {
  if (params.facilityId == undefined) {
    return -1;
  }
  
  return +params.facilityId;
}
