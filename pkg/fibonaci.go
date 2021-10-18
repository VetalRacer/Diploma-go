package pkg

import (
	"log"
	"math/big"
)

func Stress() string {
	log.Printf("[INFO] Start stress test...")
	for i := 1; i < 200; i++ {
		go factorial(big.NewInt(20000))
	}
	return "Done"
}

func factorial(x *big.Int) *big.Int {
	n := big.NewInt(1)
	if x.Cmp(big.NewInt(0)) == 0 {
		return n
	}
	return n.Mul(x, factorial(n.Sub(x, n)))
}
