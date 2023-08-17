import { sidebarRouterMap } from "@/router/sidebar-router";
import { Item, ItemName, Nav, Outer, Ul } from "./style";

function Sidebar() {
  return (
    <Outer>
      <Nav>
        <Ul>
          {sidebarRouterMap.map((router) => (
            <li key={router.path}>
              <Item
                to={router.path}
                className={({ isActive, isPending }) => (isActive ? "active" : isPending ? "pending" : "")}
              >
                <router.icon />
                <ItemName>{router.korName}</ItemName>
              </Item>
            </li>
          ))}
        </Ul>
      </Nav>
    </Outer>
  );
}

export default Sidebar;
