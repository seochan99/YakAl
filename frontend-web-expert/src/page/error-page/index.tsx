import { isRouteErrorResponse, useRouteError } from "react-router-dom";
import { Description, Div, Header, Icon, Text } from "./style";

export default function ErrorPage() {
  const error = useRouteError();
  console.error(typeof error);

  if (isRouteErrorResponse(error)) {
    if (error.status === 404) {
      return (
        <Div>
          <Icon>{":("}</Icon>
          <Text>
            <Header>404 Error</Header>
            <Description>죄송합니다. 페이지를 찾을 수 없습니다.</Description>
            <p>
              페이지가 존재하지 않거나 사용할 수 없는 페이지입니다.
              <br />
              엽력하신 주소가 정확한지 다시 한 번 확인해주세요.
            </p>
          </Text>
        </Div>
      );
    }
  } else {
    return (
      <Div>
        <Icon>{":("}</Icon>
        <Text>
          <Header>Error Page</Header>
        </Text>
      </Div>
    );
  }
}
