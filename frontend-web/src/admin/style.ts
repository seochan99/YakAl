import styled from "styled-components";

export const ListFooter = styled.div`
  & {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    font-size: 1rem;
    font-family: Pretendard, serif;
    padding: 1rem 0;
  }

  & .pagination {
    display: flex;
    flex-direction: row;
    gap: 0.8rem;
    margin: 0;
  }

  & ul {
    list-style: none;
    padding: 0;
  }

  & ul.pagination li {
    width: 2rem;
    height: 2rem;
    border-radius: 2rem;
    display: flex;
    justify-content: center;
    align-items: center;
    border: 0.1rem solid #fff;
  }

  & ul.pagination li:hover {
    background-color: var(--color-surface-900);
    cursor: pointer;
  }

  & ul.pagination li:active {
    background-color: #337ab7;
  }

  & ul.pagination li.active {
    background-color: #337ab7;
  }

  & ul.pagination li a {
    text-decoration: none;
    color: #fff;
  }

  & ul.pagination li:hover a {
    color: var(--color-surface-100);
  }

  & ul.pagination li:active a {
    color: #fff;
  }

  & ul.pagination li.active a {
    color: #fff;
  }
`;
