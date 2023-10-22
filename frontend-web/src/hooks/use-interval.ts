import { useEffect, useRef } from "react";

function useInterval(callback: () => void, delay: number) {
  const savedCallback = useRef<() => void>(() => ({}));

  useEffect(() => {
    savedCallback.current = callback;
  }, [callback]);

  useEffect(() => {
    function tick() {
      savedCallback.current();
    }

    if (delay !== null) {
      const id: NodeJS.Timer = setInterval(tick, delay);
      // eslint-disable-next-line @typescript-eslint/ban-ts-comment
      // @ts-ignore
      return () => clearInterval(id);
    }
  }, [delay]);
}

export default useInterval;
