import { LoaderFunctionArgs } from "react-router-dom";

export function loader({ params }: LoaderFunctionArgs): number {
  if (params.expertId == undefined) {
    return -1;
  }
  
  return +params.expertId;
}
