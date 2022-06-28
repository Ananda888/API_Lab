
import com.intuit.karate.junit5.Karate;

class KarateTest {

    // this will run all *.feature files that exist in sub-directories
    // see https://github.com/intuit/karate#naming-conventions
    @Karate.Test
    Karate testall() {
        return Karate.run().relativeTo(getClass()).karateEnv("qa");
    }
}


