import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'quiz_brain.dart';

void main() => runApp(const Cosmicstaan());

class Cosmicstaan extends StatelessWidget {
  const Cosmicstaan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // theme: _buildShrineTheme(),
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: const SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: MyHomePage(),
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    var bottomNavigationBarItems = <BottomNavigationBarItem>[
      const BottomNavigationBarItem(
        label: 'Blog',
        icon: Icon(Icons.article_outlined),
      ),
      const BottomNavigationBarItem(
        label: 'Quiz',
        icon: Icon(Icons.book_outlined),
      ),
      const BottomNavigationBarItem(
        label: 'About',
        icon: Icon(Icons.info_outline),
      ),
    ];
    return Scaffold(
      body: Center(
        child: PageTransitionSwitcher(
          transitionBuilder: (child, animation, secondaryAnimation) {
            return FadeThroughTransition(
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              child: child,
            );
          },
          child: _NavigationDestinationView(
            // Adding [UniqueKey] to make sure the widget rebuilds when transitioning.
            key: UniqueKey(),
            item: bottomNavigationBarItems[_currentIndex],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: bottomNavigationBarItems,
        currentIndex: _currentIndex,
        backgroundColor: colorScheme.primary,
        selectedItemColor: colorScheme.onPrimary,
        unselectedItemColor: colorScheme.onPrimary.withOpacity(.60),
        selectedLabelStyle: textTheme.caption,
        unselectedLabelStyle: textTheme.caption,
        onTap: (value) {
          setState(() => _currentIndex = value);
        },
      ),
    );
  }
}

class Blog extends StatelessWidget {
  const Blog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cosmicstaan'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          PopupMenuButton<Text>(itemBuilder: (context) {
            return [
              const PopupMenuItem(child: Text("1st Category")),
              const PopupMenuItem(child: Text("2nd Category")),
              const PopupMenuItem(child: Text("3rd Category"))
            ];
          })
        ],
        backgroundColor: colorScheme.primary,
      ),
      body: Scrollbar(
        child: ListView(
          padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
          children: [
            for (final blog in blogs(context))
              Container(
                margin: const EdgeInsets.only(bottom: 8),
                child: BlogItem(
                  article: blog,
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CreateBlog(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class Quiz extends StatelessWidget {
  const Quiz({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quiz"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
              child: Text(
                "Guide",
                style: TextStyle(fontSize: 20),
              ),
            ),
            const Text(
              "Each question will have 4 options",
            ),
            const Text(
              "One of them is correct",
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: FloatingActionButton.extended(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Quizes(),
                    ),
                  );
                },
                label: const Text("Start Quiz"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About Me"),
      ),
      body: Center(
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              ListTile(
                leading: const CircleAvatar(
                  radius: 30.0,
                  backgroundImage: AssetImage("images/space.jpg"),
                  backgroundColor: Colors.transparent,
                ),
                title: const Text('Mr. Abrax'),
                subtitle: Text(
                  'Secondary Text',
                  style: TextStyle(color: Colors.black.withOpacity(0.6)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Greyhound divisively hello coldly wonderfully marginally far upon excluding.',
                  style: TextStyle(color: Colors.black.withOpacity(0.6)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavigationDestinationView extends StatelessWidget {
  const _NavigationDestinationView({required Key key, required this.item})
      : super(key: key);

  final BottomNavigationBarItem item;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      ExcludeSemantics(
        child: Center(
          child: (item.label == "$Blog")
              ? const Blog()
              : (item.label == "$About")
                  ? const About()
                  : const Quiz(),
        ),
      ),
    ]);
  }
}

class Article {
  const Article({
    required this.assetName,
    required this.title,
    required this.description,
    required this.content,
  });

  final String assetName;
  final String title;
  final String description;
  final String content;
}

List<Article> blogs(BuildContext context) => [
      const Article(
          assetName: 'images/1st.webp',
          title:
              "SpaceX's private Inspiration4 crew gets their astronaut wings",
          description:
              "The four private space travelers who soared into orbit on SpaceX's historic Inspiration4  mission last month officially have their astronaut wings.",
          content:
              """The four private space travelers who soared into orbit on SpaceX's historic 
Inspiration4  mission last month officially have their astronaut wings.
The civilian crew, which rode a SpaceX Dragon spacecraft into orbit on Sept. 15
and returned to Earth three days later, received their astronaut wings from the
company on Friday (Oct. 1) in a presentation at SpaceX's headquarters in
Hawthorne, California. 
"Yesterday we were presented with our SpaceX astronaut wings," Inspiration4
astronaut Hayley Arceneaux, the mission's medical officer, wrote in a Twitter post
 Saturday. "This beautiful symbol of our journey means everything to me! Also if it
looks like I'm crying, mind your business." 
Yesterday we were presented with our SpaceX astronaut wings. This beautiful symbol 
of our journey means everything to me! Also if it looks like I’m crying, mind your 
business 😉😉 pic.twitter.com/3TqMQ91okKOctober 2, 2021
Arceneaux wasn't alone in her jubilation. 
"I cried when I got my wings!" Sian Proctor, a geoscientist and space communicator
who served as the Inspiration4 crew's pilot on the mission, wrote on Twitter. 
SpaceX's astronaut wings pin has a Crew Dragon capsule at its center from which
emerge a dragon's head and wings. The back is inscribed with each crewmember's
name, call sign and mission role. 
Inspiration4 was a three-day commercial space mission financed by American
entrepreneur and billionaire Jared Isaacman, who bought four seats to orbit on a SpaceX
Dragon and Falcon 9 rocket. Isaacman donated three of the seats to raise funds and
awareness for childhood cancer research by St. Jude Children's Research Hospital.
Arceneaux, a St. Jude physicians assistant and childhood bone cancer survivor,
represented the hospital on the flight. Proctor and another civilian, aerospace data
engineer Chris Sembroski, won their seats as part of public contests. They were the
first all-civilian crew to fly in space without a professional astronaut, and Proctor
became the first Black female spaceship pilot in history on the flight.
During their flight, the Inspiration4 astronauts spent three days circling the Earth,
performing science experiments and gazing out the largest single window ever built
for space, a dome-shaped cupola that SpaceX attached to the nose of the Dragon
capsule for the mission. Their mission is the subject of a Netflix documentary series
 and raised over \$200 million for St. Jude. 
"Until we meet again, thank you to all the amazing people at @SpaceX who have
done so much for me and @inspiration4x," Sembroski, Inspiration4's mission
specialist, wrote on Twitter. "And most of all, thanks to my beautiful wife Erin who
gave so much to support this dream on a most incredible journey."
According to SpaceX and the Inspiration4 teams, the private astronauts were
invited to the company's headquarters Friday to share the experiences from their
spaceflight. The astronaut wings presentation was apparently a surprise. 
"Our Inspiration4 crew visited SpaceX's headquarters in Hawthorne, California
yesterday, and was surprised with SpaceX Dragon wings," Inspiration4's outreach
team wrote on Twitter.
Isaacman, who has not disclosed how much be paid for the Inspiration4 flight,
thanked SpaceX on Saturday for the flight.
"It was great to see all our SpaceX friends and thank them for making this mission a
success," Isaacman added on Twitter. "Incredible memories."""),
      const Article(
          assetName: 'images/2nd.jpg',
          title: "Full Moon Calendar 2021: When to see the next full moon",
          description: "Here are the dates for the full moons in 2021.",
          content:
              """he full moon shows its face to Earth about once a month. Well, sort of. 
Most of the time, the full moon isn't perfectly full. We always see the same side of
the moon, but part of it is in shadow. Only when the moon, Earth and the sun are
perfectly aligned is the moon 100% full, and that alignment produces a lunar eclipse
. 
And sometimes — once in a blue moon — the moon is full twice in a month (or four
times in a season, depending on which definition you prefer). 
The next full moon will occur on Wednesday, Oct. 20 at 10:57 a.m. EDT (14:57 UTC)
, but the moon will appear full the night before and after its peak to the casual
stargazer. October's full moon is the known as the Hunter's Moon among other
names.
If you enjoy observing the moon, take note: Oct. 16 is International Observe the
Moon Night, as it's one of the best times of the month to gaze at the moon. You can
find out how to join an event, host your own or participate in other ways with
NASA's International Observe the Moon Night website.
If you know a youngster who can't get enough of the moon, then they'll be delighted with
views through the Orion GoScope II. Revealing craters and seas up close, this little
telescope comes with a carry case and moon map.
This is when full moons will occur in 2021, according to NASA:
 Date     Name       U.S. Eastern Time UTC
Jan 28  Wolf Moon       2:16 p.m. 19:16
Feb 27  Snow Moon       3:17 a.m. 8:17
Mar 28  Worm Moon       2:48 p.m. 18:48
Apr 26  Pink Moon       11:31 p.m. 3:31 (Apr. 27)
May 26  Flower Moon     7:14 a.m. 11:14
Jun 24  Strawberry Moon 2:40 p.m. 18:40
Jul 23  Buck Moon       10:37 p.m. 2:37 (Jul 24)
Aug 22  Sturgeon Moon   8:02 a.m. 12:02
Sep 20  Harvest Moon    7:55 p.m. 23:55
Oct 20  Hunter's Moon   10:57 a.m. 14:57
Nov 19  Beaver Moon     3:58 a.m. 8:58
Dec 18  Cold Moon       11:36 p.m. 4:36 (Dec 19)
Many cultures have given distinct names to each month's full moon. The names were
applied to the entire month in which each occurred. The Farmer's Almanac lists several
names that are commonly used in the United States. There are some variations in the
moon names, but in general, the same ones were used among the Algonquin tribes from
New England on west to Lake Superior. European settlers followed their own customs and
created some of their own names.
Other Native American people had different names. In the book "This Day in North 
American Indian History" (Da Capo Press, 2002), author Phil Konstantin lists more
than 50 native peoples and their names for full moons. He also lists them on his
website, AmericanIndian.net.
Amateur astronomer Keith Cooley has a brief list of the moon names of other 
cultures, including Chinese and Celtic, on his website. For example,
Chinese moon names:
Month Name Month Name
January Holiday Moon July Hungry Ghost Moon
February Budding Moon August Harvest Moon
March Sleepy Moon September Chrysanthemum Moon
April Peony Moon October Kindly moon
May Dragon Moon November White Moon
June Lotus Moon December Bitter Moon
Full moon names often correspond to seasonal markers, so a Harvest Moon occurs
at the end of the growing season, in September or October, and the Cold Moon
occurs in frosty December. At least, that's how it works in the Northern
Hemisphere.
In the Southern Hemisphere, where the seasons are switched, the Harvest Moon
occurs in March and the Cold Moon is in June. According to Earthsky.org, these are
common names for full moons south of the equator.
January: Hay Moon, Buck Moon, Thunder Moon, Mead Moon
February (mid-summer): Grain Moon, Sturgeon Moon, Red Moon, Wyrt Moon, Corn
Moon, Dog Moon, Barley Moon
March: Harvest Moon, Corn Moon
April: Harvest Moon, Hunter’s Moon, Blood Moon
May: Hunter’s Moon, Beaver Moon, Frost Moon
June: Oak Moon, Cold Moon, Long Night’s Moon
July: Wolf Moon, Old Moon, Ice Moon
August: Snow Moon, Storm Moon, Hunger Moon, Wolf Moon
September: Worm Moon, Lenten Moon, Crow Moon, Sugar Moon, Chaste Moon, Sap Moon
October: Egg Moon, Fish Moon, Seed Moon, Pink Moon, Waking Moon
November: Corn Moon, Milk Moon, Flower Moon, Hare Moon
December: Strawberry Moon, Honey Moon, Rose Moon
The moon is a sphere that travels once around Earth every 27.3 days. It also takes
about 27 days for the moon to rotate on its axis. So, the moon always shows us the
same face; there is no single "dark side" of the moon. As the moon revolves around
Earth, it is illuminated from varying angles by the sun — what we see when we look
at the moon is reflected sunlight. On average, the moon rises about 50 minutes
later each day, which means sometimes it rises during daylight and other times at
night.
There are four phases of the moon:
At new moon, the moon is between Earth and the sun, so that the side of the moon
facing toward us receives no direct sunlight, and is lit only by dim sunlight reflected
from Earth.
A few days later, as the moon moves around Earth, the side we can see gradually
becomes more illuminated by direct sunlight. This thin sliver is called the waxing
crescent.
A week after the new moon, the moon is 90 degrees away from the sun in the sky
and is half-illuminated from our point of view — what we call first quarter because
it is about a quarter of the way around Earth.
A few days later, the area of illumination continues to increase. More than half of
the moon's face appears to be getting sunlight. This phase is called a waxing
gibbous moon.

When the moon has moved 180 degrees from its new moon position, the sun, Earth
and the moon form a line. The moon’s disk is as close as it can be to being fully
illuminated by the sun, so this is called full moon.
Next, the moon moves until more than half of its face appears to be getting
sunlight, but the amount is decreasing. This is the waning gibbous phase.
Days later, the moon has moved another quarter of the way around Earth, to the
third quarter position. The sun's light is now shining on the other half of the visible
face of the moon.
Next, the moon moves into the waning crescent phase as less than half of its face
appears to be getting sunlight, and the amount is decreasing.
Finally, the moon moves back to its new moon starting position. Because the moon’s orbit
is not exactly in the same plane as Earth’s orbit around the sun, they rarely are perfectly
aligned. Usually the moon passes above or below the sun from our vantage point, but
occasionally it passes right in front of the sun, and we get an eclipse of the sun.
Each full moon is calculated to occur at an exact moment, which may or may not be near
the time the moon rises where you are. So when a full moon rises, it’s typically doing so
some hours before or after the actual time when it’s technically full, but a casual
skywatcher won’t notice the difference. In fact, the moon will often look roughly the same
on two consecutive nights surrounding the full moon.
When the moon is in its full phase, it is passing behind the Earth with respect the sun and
can pass through Earth's shadow, creating a lunar eclipse. When the moon is fully inside
the Earth's shadow, we see a total lunar eclipse. At other times, the moon only partially
passes through the Earth's shadow in what is known as a partial, or even penumbral lunar
eclipse (when the moon only skirts through the outermost region of Earth's shadow). 
In 2021, there will be two lunar eclipses. A total lunar eclipse will occur on May 26,
and a partial lunar eclipse will occur on Nov. 19. 
The total lunar eclipse of May 26 will only be visible across parts of East Asia,
Australia, the Pacific Ocean and North and South America. It will begin at 4:47 a.m.
EDT (0847 GMT) and end at 9:49 a.m. EDT (1349 GMT). 
The partial lunar eclipse of Nov. 19 will be visible in the predawn hours across North and South America, 
northern Europe, East Asia, Australia and the Pacific Ocean. It will begin at 1:02 a.m. EST (0602 GMT) 
and end at 7:03 a.m. EST (1203 GMT). 
Because the moon's orbit around the Earth is tilted, it does not line up with Earth's shadow every month
and we do not have a lunar eclipse each month.
When the moon is in its "new" phase, it passing between the Earth and the sun, so
the side facing the Earth appears dark.  
Occasionally, the moon's orbit lines up with the sun in such away that part or all of
the sun can be blocked by the moon, as viewed from Earth. When the moon
completely blocks the sun's disk, we see a total solar eclipse during the day, which
can be a truly awe-inspiring site. Other times, the moon can only partially block the
sun in a partial solar eclipse. 
The moon can even create a "ring of fire" solar eclipse when it passes directly in
front the sun, but is at a point in its orbit that is too far from Earth to fully cover the
sun's disk. This leaves a ring, or "annulus," around the moon to create what is called
an annular solar eclipse. 
There will be two solar eclipses in 2021. An annular "ring of fire" solar eclipse will
occur on June 10, 2021. It will be visible as a partial eclipse from regions of North
America, Europe and Asia, with the "ring of fire" effect visible from northern
Canada, Greenland and Russia. 
The total solar eclipse of 2021 will occur on Dec. 4. It will only be visible in totality
from Antarctica, with partial views visible from South Africa and the South Atlantic. """),
      const Article(
          assetName: 'images/3rd.jpg',
          title:
              "Hubble telescope spots celestial 'eye,' a galaxy with an incredibly active core",
          description:
              "A cosmic hurricane shows its 'eye' in a new image from the Hubble Space Telescope",
          content:
              """The spiral galaxy NGC 5728 has quite a powerhouse at its center. This structure
located 130 million light-years from Earth in the constellation Libra is in a unique
cosmic category thanks to its active core. 
NGC 5728 is a Seyfert galaxy, which means that one of its particular characteristics
is the active galactic nucleus at its core that shines bright thanks to all the gas and
dust that is hurled around its central black hole. Sometimes galactic cores are busy
and luminous enough to outshine the rest of the galaxy in visible and infrared light.
But Seyfert galaxies like NGC 5728 are a special Goldilocks treat, because human
instruments can still view the rest of Seyfert galaxies clearly
The European Space Agency (ESA) published this new image on Monday (Sept. 27).
According to ESA, which jointly operates the Hubble Space Telescope with NASA, the
spacecraft used its Wide Field Camera 3 (WFC3) to capture this view. Officials said in a 
statement that describes the photo that even as glorious as this cosmic scene appears here,
there is also a lot going on near NGC 5728 that the camera doesn't capture.
"As this image shows, NGC 5728 is clearly observable, and at optical and infrared
wavelengths it looks quite normal," ESA officials wrote in the description. "It is
fascinating to know that the galaxy's centre is emitting vast amounts of light in
parts of the electromagnetic spectrum that WFC3 just isn't sensitive to!"
It turns out that the iris of NGC 5728's galactic 'eye' might in fact be emitting some
visible and infrared light that the camera would otherwise detect if it weren't for the
glowing dust surrounding the core. 
Doris Elin Urrutia joined Space.com as an intern in the summer of 2017. She received a B.A.
in Sociology and Communications at Fordham University in New York City. Her work was
previously published in collaboration with London Mining Network. Her passion for geology
and the cosmos started when she helped her sister build a model solar system in a Bronx
library. Doris also likes learning new ways to prepare the basil sitting on her windowsill.
Follow her on twitter at @salazar_elin."""),
      const Article(
          assetName: 'images/4th.jpg',
          title:
              "After 3.5 million-year hiatus, the largest comet ever discovered is headed our way",
          description:
              "The gargantuan Bernardinelli-Bernstein comet will strafe Saturn's orbit in 2031. Scientists are stoked.",
          content:
              """An enormous comet — possibly the largest one ever detected — is barreling toward
the inner solar system with an estimated arrival time of 10 years from now,
according to new research published on the preprint server arXiv.org.
The comet, known as the Bernardinelli­Bernstein comet (or C/2014 UN271, in astrospeak), is at least 62 miles (100 kilometers) across — about 1,000 times more
massive than a typical comet. It's so large that astronomers previously mistook it
for a dwarf planet, according to a statement announcing the comet’s discovery in
June 2021.
But a closer analysis of the object revealed that it was moving rapidly through the
Oort cloud — a vast scrapyard of icy rocks, billions of miles from Earth. The object
appeared to be headed our way, and it even had a glowing tail, or "coma", behind it
— a clear indication of an icy comet approaching the relatively warm inner solar 
system.
Now, researchers have studied the massive comet in more detail, and they have
new estimates about its journey toward the sun.
For starters, the enormous rock poses no threat to Earth. Right now, BernardinelliBernstein (BB) is cruising through the Oort cloud at about 29 times the distance
between Earth and the sun, or 29 astronomical units (AU). The comet's closest
approach to Earth will occur sometime in the year 2031, when scientists predict the
comet will swoop within 10.97 AU of the sun — putting it just outside of Saturn's
orbit, according to the researchers.
While that's far enough from Earth that humans won't be able to see the comet
without telescopes, it's considerably closer than the rock's last visit to our part of
the solar system. After modeling the comet's trajectory, the study authors
calculated that comet BB made its last approach 3.5 million years ago, coming
within 18 AU of the sun.
Since then, the comet traveled as far as 40,000 AU away, deep into the mysterious
Oort cloud, according to the researchers.
"We conclude that BB is a 'new' comet in the sense that there is no evidence for [a]
previous approach closer than 18 AU," the researchers wrote in their study; in other words,
humans have never laid eyes on it before.
We owe our current view of the large, distant comet to the Dark Energy Survey
(DES) — a project to study the expansion of the universe, which ran between
August 2013 and January 2019. During the survey, astronomers mapped 300 million
galaxies in the southern sky, discovering more than 800 previously unknown
objects beyond the orbit of Neptune. The Bernardinelli-Bernstein comet was one of
those objects.
Researchers have plenty of time to study the massive comet as it soars ever closer
to Earth over the next decade. Getting a closer look at the rock could help scientists
understand a bit more about the chemical composition of the early solar system, as
comets from deep in the Oort cloud are thought to be relatively unchanged since
they were booted away from the sun billions of years ago. With millions of years
separating the comet's next close approach from its following one, it'll be a once-ina-lifetime brush with the early solar system.
Brandon Specktor writes about the science of everyday life for Live Science, and previously
for Reader's Digest magazine, where he served as an editor for five years. He grew up in
the Sonoran Desert, but believes Sonoran hot dogs are trying way too hard."""),
      const Article(
          assetName: 'images/5th.jpg',
          title:
              "On This Day in Space! Oct. 3, 1942: 1st successful test launch of the German A4 rocket (AKA the V-2)",
          description:
              "On Oct. 3, 1942, Germany did the first-ever successful test launch of a ballistic missile.",
          content:
              """This missile was officially named Aggregat 4 (A4) but more commonly known as the
V-2. The V-2 was designed by the famous German rocket scientist Wernher von 
Braun, and it proved to be a super deadly weapon during World War II. 
It launched from an island off the Baltic coast of Germany called Peenemünde and
reached an altitude of 52.5 miles (84.5 kilometers) before safely landing right on
target 118 miles (190 km) away.
Still not enough space? Don't forget to check out our Space Image of the Day, and on the
weekends our Best Space Photos and Top Space News Stories of the week. 
Hanneke Weitering is an editor at Space.com with 10 years of experience in science
journalism. She has previously written for Scholastic Classroom Magazines, MedPage
Today and The Joint Institute for Computational Sciences at Oak Ridge National Laboratory.
After studying physics at the University of Tennessee in her hometown of Knoxville, she
earned her graduate degree in Science, Health and Environmental Reporting (SHERP) from
New York University. Hanneke joined the Space.com team in 2016 as a staff writer and
producer, covering topics including spaceflight and astronomy. She currently lives in
Seattle, home of the Space Needle, with her cat and two snakes. In her spare time Hanneke
likes to explore the Rocky Mountains, basking in nature and looking for dark skies to gaze
at the cosmos. """),
      const Article(
          assetName: 'images/6th.jpg',
          title:
              "Mercury looks stunning in this 1st flyby photo from Europe and Japan's BepiColombo mission",
          description:
              "Two spacecraft built by Europe and Japan captured their first up-close look at the planet Mercury in a weekend flyby, revealing a rocky world covered with craters.",
          content:
              """Two spacecraft built by Europe and Japan captured their first up-close look at the
planet Mercury in a weekend flyby, revealing a rocky world covered with craters. 
The two linked probes, known together as BepiColombo, snapped their first image
of Mercury late Friday (Oct. 1) during a flyby that sent them zooming around the
planet. The encounter marked the first of six Mercury flybys for BepiColombo, a
joint effort by the space agencies of Europe and Japan, to slow itself enough to
enter orbit around the planet in 2025.
BepiColombo took its first official photo of Mercury at 7:44 p.m. EDT (2344 GMT)
with its Mercury Transfer Module Monitoring Camera 2, a black-and-white
navigation camera, as the probe was about 1,502 miles (2,418 kilometers) away
from the planet, according to the European Space Agency (ESA). Just 10 minutes
earlier, at 7:34 p.m. EDT, BepiColombo made its closest approach to Mercury,
passing within 124 miles (200 km) of the planet.
Dozens of craters are visible on the surface of Mercury in BepiColombo's photo, as
are a boom, thruster and other parts of the spacecraft's structure. 
"The region shown is part of Mercury's northern hemisphere including Sihtu
Planitia that has been flooded by lavas. A round area smoother and brighter than
its surroundings characterizes the plains around the Calvino crater, which are called
the Rudaki Plains," ESA officials wrote in a photo description. "The 166 km-wide
Lermontov crater is also seen, which looks bright because it contains features 
unique to Mercury called 'hollows' where volatile elements are escaping to space. It
also contains a vent where volcanic explosions have occurred."
ESA also released an annotated image identifying the major Mercury craters in
BepiColombo's image alongside the raw photo. More photos are expected to be 
released in coming days as they are processed by BepiColombo's science team.
The \$750 million BepiColombo mission consists of two different orbiters designed
to study Mercury in unprecedented detail with a total of 16 different instruments.
ESA's contribution is the Mercury Planetary Orbiter to study the planet from above
while the Mercury Magnetospheric Orbiter, built by the Japan Aerospace
Exploration Agency, will study the planet's magnetic field, plasma environment and
dust.
The two orbiters are riding to their target planet on the Mercury Transfer Module
on a seven-year trip that began with a launch in 2018. So far, BepiColombo has
successfully made four flybys of three different planets: one of Earth in April 2020,
two of Venus (in October 2020 and August 2021) and now one of Mercury. 
The next Mercury flyby is scheduled for June 20, 2022 and will be followed by four
more flybys in June 2023, September and December of 2024, and January 2025. If
all goes well, BepiColombo is expected to enter orbit around Mercury on Dec. 5,
2025.
Tariq is the Editor-in-Chief of Space.com and joined the team in 2001 as a staff writer, and
later editor, covering human spaceflight, exploration and space science. He became
Space.com's Managing Editor in 2009 and Editor-in-Chief in 2019. Before joining
Space.com, Tariq was a staff reporter for The Los Angeles Times. He is also an Eagle Scout
(yes, he has the Space Exploration merit badge) and went to Space Camp four times as a
kid and a fifth time as an adult. He has journalism degrees from the University of Southern
California and New York University. To see his latest project, you can follow Tariq
on Twitter."""),
      const Article(
          assetName: 'images/7th.webp',
          title:
              "Unstoppable lava from La Palma volcano eruption reaches ocean in stunning space photos",
          description:
              "The volcanic eruption on Spain's La Palma island shows no signs of stopping.",
          content:
              """New images from space of the La Palma volcano eruption in the Canary Islands
show the unstoppable river of lava flowing into the Atlantic Ocean just as locals
report new earthquakes in the region. 
The burning lava scar on the western flanks of La Palma, one of the islands of the
Spain-governed Canary archipelago off the coast of northwest Africa, glows brightly
in nighttime images captured by U.S. Earth observation company Maxar
Technologies on Thursday (Sept. 30). The images clearly reveal the area on the left
where the lava flow spills into the Atlantic Ocean at the secluded Playa Nueva beach
near the town of Tazacorte.
The Volcanic Institute of the Canaries (Involcan) reported the solidifying lava has
created a new penninsula, that is already larger than 25 soccer pitches, The 
Guardian reported.
Russian cosmonauts Oleg Novitsky and Pyotr Dubrov on the International Space 
Station also photographed the eruption from orbit and shared the images on
Twitter a day after capturing them on Wednesday (Sept. 29). 
The image, shared by Novitsky on Thursday (Sept. 30), shows a glowing lava river
considerably outshining the urban network of lights as the island and the
surrounding ocean hide in darkness.
"Yesterday Pyotr Dubrov and I managed to capture the volcano's magma from the
ISS at night," Novitsky said in the tweet.
The European Union's Copernicus Earth observation program also shared new images of
the ongoing eruption today, saying that more than 1,000 buildings have been buried in the
boiling stream of lava since the eruption started on Sept. 19.
Over 1.4 square miles (3.6 square kilometers) of land have been buried so far as the
eruption shows no signs of stopping. A series of mild earthquakes up to the magnitude of
3.5 shook the island on Friday (Oct.1) and a new lava-spewing fissure opened about 1,310
feet (400 meters) north from the original crater of the Cumbre Vieja volcano, according to 
Sky News. 
More than 6,000 people  including hundreds of tourists have been evacuated since the
eruption started and three coastal villages are currently locked down as geologists worry
the boiling lava mixing with cool sea water might release toxic gases. 
he eruption, the first for Cumbre Vieja since 1971, had been preceded by more than 20,000
mild Earth tremors in the week prior to the first fissure opening. Involcan predicts the
eruption may continue for weeks or even months
Tereza is a London-based science and technology journalist, aspiring fiction writer and
amateur gymnast. Originally from Prague, the Czech Republic, she spent the first seven
years of her career working as a reporter, script-writer and presenter for various TV
programmes of the Czech Public Service Television. She later took a career break to pursue
further education and added a Master's in Science from the International Space University,
France, to her Bachelor's in Journalism and Master's in Cultural Anthropology from
Prague's Charles University. She worked as a reporter at the Engineering and Technology
magazine, freelanced for a range of publications including Live Science, Space.com,
Professional Engineering, Via Satellite and Space News and served as a maternity cover
science editor at the European Space Agency."""),
      const Article(
          assetName: 'images/8th.webp',
          title:
              "Jeff Bezos' Blue Origin faces scathing criticism of safety and culture",
          description:
              "With Blue Origin's second crewed flight less than two weeks away, the company is facing scathing allegations about its culture and the safety of its suborbital launch system, New Shepard.",
          content:
              """The Federal Aviation Administration (FAA) is now considering concerns related to
vehicle safety that were raised in a detailed essay published by the Lioness on
Thursday (Sept. 30). In the essay, 21 past and current Blue Origin employees, all but
one of them remaining anonymous, raise a string of concerns about the company's
culture, including allegations of sexism, corporate suppression of dissent, disdain
for sustainability and a habit of prioritizing schedules above safety when it comes to
New Shepard.
"The FAA takes every safety allegation seriously, and the agency is reviewing the
information," an agency spokesperson told Space.com in an email.
The allegations come about two months after Blue Origin's founder, Amazon's Jeff
Bezos, rode his company's suborbital launch system on an exultant 10-minute long
flight, the vehicle's first ever crewed mission — and just days after the company
announced that its next crewed mission would launch on Oct. 12.
At the time, the company also identified two of the four passengers on the Oct. 12
flight: Chris Boshuizen, a co-founder of Earth-observation company Planet, and
Glen de Vries, who is vice chair for life sciences and healthcare at a French software
company. De Vries told The New York Times that he was not concerned about
safety on the upcoming flight.
"I am confident in Blue Origin's safety program, spacecraft, and track record, and
certainly wouldn't be flying with them if I wasn't," he told The New York Times. "I've
been to the launch site, met people at every level of the company, and everything
I've seen was indicative of a great team and culture."
In a statement, the company rejected the allegations aired in the Lioness piece. "Blue
Origin has no tolerance for discrimination or harassment of any kind," a company
spokesperson told Space.com by email. "We provide numerous avenues for employees, 
including a 24/7 anonymous hotline, and will promptly investigate any new claims of
misconduct. We stand by our safety record and believe that New Shepard is the safest
space vehicle ever designed or built."
New Shepard, a reusable rocket-capsule combo, has flown 17 times without incident.
In an email to employees obtained by CNBC, CEO Bob Smith wrote to "reassure"
workers. "First, the New Shepard team went through a methodical and pain-staking
process to certify our vehicle for First Human Flight. Anyone that claims otherwise is
uninformed and simply incorrect," he wrote, according to CNBC. "It should also be
emphatically stated that we have no tolerance for discrimination or harassment of
any kind."
The essay, which reads as a scathing indictment of the company's culture, marks
the second publication by Lioness, a company that bills itself as a "storytelling
platform" and also works to arrange media coverage of its features. Only one of the
21 signatories is named publicly: Alexandra Abrams, who worked in Blue Origin's
communications department from June 2017 to November 2019, according to her
LinkedIn profile.
In the statement, the Blue Origin spokesperson wrote, "Ms. Abrams was dismissed
for cause two years ago after repeated warnings for issues involving federal export
control regulations"; Abrams has said that she was told leadership no longer
trusted her.
In an interview with CBS Mornings, Abrams offered a little more detail about the
group behind the essay, noting that 13 of the 21 people are or were "engineers or
technical" personnel. "They span all the major programs of the company, and they
also span different levels," Abrams said. Later in the interview, she noted that the
group "includ[es] very senior people."
The essay touches on a range of issues, but the authors highlighted safety as their
motivation, calling it "for many of us ... the driving force for coming forward with this
essay." The essay paints a portrait of a corporate culture that devalues safety concerns and
risk management.
"Some of us felt that with the resources and staff available, leadership’s race to
launch at such a breakneck speed was seriously compromising flight safety," the
authors wrote, comparing the situation to the environment at NASA discovered after
the 1986 explosion of the space shuttle Challenger 73 seconds after launch.
"Concerns related to flying New Shepard were consistently shut down, and women
were demeaned for raising them," the authors wrote. "In the opinion of an engineer
who has signed on to this essay, 'Blue Origin has been lucky that nothing has 
happened so far.' Many of this essay's authors say they would not fly on a Blue
Origin vehicle."
The letter is sparse on specific allegations, but three items stand out as relatively
detailed concerns.
One is a reference to a backlog of more than 1,000 unaddressed "problem reports"
in 2018 regarding "the engines that power Blue Origin's rockets." The engine in
question is likely the company's BE-3, which uses a mix of liquid oxygen and liquid
hydrogen and made its first flight in 2015, according to the company's website.
According to the website, the company is still testing a new model of BE-3 for use
on its planned orbital vehicle, New Glenn. (Other engines Blue Origin is building
include the much­delayed BE­4, which is in testing and slated for use on New Glenn
and United Launch Alliance's Vulcan, and the BE-7, which is also still in
development.)
In addition to the engine problem reports, the essay writers also pointed to
insufficient staffing on an unspecified aspect of New Shepard. "In 2019, the team
assigned to operate and maintain one of New Shepard's subsystems included only
a few engineers working long hours," they wrote. "Their responsibilities, in some of
our opinions, went far beyond what would be manageable for a team double the
size, ranging from investigating the root cause of failures to conducting regular
preventative maintenance on the rocket's systems."
And the essay writers also noted steps taken out of order in New Shepard's
development. "Internally, many of us did not see leadership invest in prioritizing
sound systems engineering practices," they wrote. "Systems engineering products
were created for New Shepard after it was built and flying, rather than in the design
phase; this impacted verification efforts."
Abrams told CBS Mornings that, while she was employed at Blue Origin, she
approached management about safety concerns reported by technical staff and
was rebuffed. "Oftentimes, when I would try to reconcile what I was hearing from
the engineers who were close to the vehicle versus leadership about risk and
safety, I would often go to leadership and say, 'OK, how am I supposed to think
about this?'" Abrams said. "Often the response would be, 'Oh, well, that person in
particular doesn't have a high enough risk tolerance.'"
According to the interview, the co-authors sent the essay to the FAA before
publication in order to flag the safety concerns.
Schedule and spending over safety 
The essay and Abrams' interview with CBS both connect the downplaying of risks
with the company's broader culture. "You cannot create a culture of safety and a
culture of fear at the same time. They are incompatible," Abrams said.
In the opinion of Abrams and her co-authors, the company's blasé safety
philosophy developed primarily in response to the "billionaire space race" idea that
developed between three rival private space companies: Bezos' Blue Origin, Elon
Musk's SpaceX and Richard Branson's Virgin Galactic.
Abrams told CBS Mornings that the company's atmosphere was pleasant when she
first joined, but it quickly soured. "It was great that Blue Origin was smooth and
steady and slow — until Jeff [Bezos] started becoming impatient and Elon [Musk]
and Branson were getting ahead," Abrams said. "Then we started to feel this
increasing pressure and impatience that would definitely filter down from
leadership."
When asked, Abrams agreed that, at the time, competition seemed to take
precedence over safety in guiding Blue Origin's decisions.
The essay also ties safety lapses to competition and Bezos' personal priorities. "At
Blue Origin, a common question during high-level meetings was, 'When will Elon or
Branson fly?,'" the authors wrote. "Competing with other billionaires — and 'making
progress for Jeff' — seemed to take precedence over safety concerns that would
have slowed down the schedule."
(Bezos' rivalry with Musk may be especially intense, as the two billionaires have 
traded barbs repeatedly over the years.) 
But the group notes other factors that they see as contributing to the
deprioritization of safety as well.
They wrote of a budget-conscious culture and an emphasis on slim spending even
when projects were made more ambitious. "Employees are often told to 'be careful
with Jeff's money,' to 'not ask for more,' and to 'be grateful,'" they wrote. And both
the essay and Abrams' remarks point to increasingly aggressive contract terms for 
employees, including pressuring existing employees to sign non-disclosure
agreements.
The group also described diversity shortcomings and "a particular brand of sexism,"
including at high levels of the company despite its idealistic goals. "The workforce
dedicated to establishing this future 'for all' is mostly male and overwhelmingly
white," they wrote. "One-hundred percent of the senior technical and program
leaders are men." They describe sexist remarks from two unnamed senior figures
and leadership's "clear bias against women," manifested in situations like the
treatment of departing employees.
The essay also accuses the company of dismissing environmental concerns and
Bezos of acting counter to his public donations to environmental causes.
In general, the essay targets company leadership as a whole and the culture that
leadership has created, with no specific allegations against Bezos, although Abrams
mentioned him specifically in the CBS Mornings interview.
"I think I would say to Jeff that I really wish he was the person we all thought he was
and that Blue Origin was the company we all thought it was going to be," she said.
Blue Origin's publicity blues
 The essay marks another publicity blow for Blue Origin, which appears to be deep
into bickering with its rival billionaire-founded space companies.
The company is sparring with SpaceX over a hotly desired contract for NASA's Human
Landing System (HLS), the component designed to ferry astronauts from lunar orbit
to the moon's surface, perhaps as early as 2024.
NASA officials had previously said that they would like to select more than one
concept for HLS funding. But in April 2021, after receiving much less funding for the
project from Congress than the agency had requested, NASA decided to fund
development work only from SpaceX, which had submitted a cheaper bid than the
Blue Origin-led "National Team" or the third entrant in the competition, Dynetics.
Blue Origin responded by filing a protest with the agency's internal Office of
Inspector General (as Dynetics did as well). When that tactic failed, Blue Origin
decided to sue NASA.
As a result, the agency and SpaceX cannot work on HLS until November. All told, the
objections will mean minimal work completed even six months after the contract's
announcement. Meanwhile, in July, Bezos penned an open letter to NASA
Administrator Bill Nelson offering to cover some costs of a Blue Origin HLS program
in-house and raising a host of complaints about the process behind the contract.
The company even raised eyebrows around its greatest success to date, Bezos' own
flight. After Branson announced that he would fly on Virgin Galactic's suborbital
tourism system just over a week before Bezos' announced flight date, Blue Origin
dug into a bitter publicity push comparing the two flight systems.
Such efforts perhaps didn't come as much of a surprise to the Lioness essay
authors.
"Billionaires may like to present themselves as altruistic, using their resources for
the benefit of humanity; in our opinion, however, much of that image is an illusion
created by public relations teams, underpinned by ego," the authors wrote.
The essay authors note that they're happy to have billionaires fund space
exploration. But they argue that it's important to consider the wider implications
that an environment like the one they claim Bezos has fostered has for the space
community.
"In our experience, Blue Origin’s culture sits on a foundation that ignores the plight
of our planet, turns a blind eye to sexism, is not sufficiently attuned to safety
concerns, and silences those who seek to correct wrongs," the essay reads. "That's
not the world we should be creating here on Earth, and certainly not as our
springboard to a better one."
"""),
      const Article(
          assetName: 'images/9th.webp',
          title:
              "Air Force's X-37B robotic space plane wings past 500 days in Earth orbit",
          description:
              "That enigmatic U.S. military X-37B robotic space drone has now chalked up more than 500 days circling the Earth.",
          content:
              """The Orbital Test Vehicle (OTV-6) is also called USSF-7 for the U.S. Space Force and
launched May 17, 2020, on an Atlas V 501 booster.
OTV-6 is the first to use a service module to host experiments. The service module
is an attachment to the aft of the vehicle that allows additional experimental
payload capability to be carried to orbit.
Primary agenda: classified
While the Boeing-built robotic space plane's on-orbit primary agenda is classified,
some of its onboard experiments were identified pre-launch.
One experiment onboard the space plane is from the U.S. Naval Research
Laboratory (NRL), an investigation into transforming solar power into radio
frequency microwave energy. The experiment itself is called the Photovoltaic Radiofrequency Antenna Module, PRAM for short.
Along with toting NRL's PRAM into Earth orbit, the X­37B also deployed the
FalconSat-8, a small satellite developed by the U.S. Air Force Academy and
sponsored by the Air Force Research Laboratory to conduct several experiments on
orbit.
In addition, two NASA experiments are also onboard the space plane to study the
effects of the space environment on a materials sample plate and seeds used to
grow food.
Previous flights
OTV­1: launched on April 22, 2010 and landed on Dec. 3, 2010, spending over 224
days on orbit.
OTV­2: launched on March 5, 2011 and landed on June 16, 2012, spending over 468
days on orbit.
OTV­3: launched on Dec. 11, 2012 and landed on Oct. 17, 2014, spending over 674
days on-orbit.
OTV­4: launched on May 20, 2015 and landed on May 7, 2015, spending nearly 718
days on-orbit.
OTV­5: launched on Sept. 7, 2017 and landed on Oct. 27, 2019, spending nearly 780
days on-orbit.
OTV-1, OTV-2, and OTV-3 missions landed at Vandenberg Air Force Base, California,
while the OTV-4 and OTV-5 missions landed at Kennedy Space Center, Florida.
There is no word on when and where OTV-6 will return to Earth.
According to a Boeing fact sheet, "the X-37B is one of the world's newest and most
advanced re-entry spacecraft, designed to operate in low-earth orbit, 150 to 500
miles above the Earth. The vehicle is the first since the space shuttle with the ability
to return experiments to Earth for further inspection and analysis. This United
States Air Force unmanned space vehicle explores reusable vehicle technologies
that support long-term space objectives.
Delta 9
The X-37B program is flown under the wing of a U.S. Space Force unit called Delta 9,
established and activated July 24, 2020.
"Delta 9 Detachment 1 oversees operations of the X-37B Orbital Test Vehicle, an
experimental program designed to demonstrate technologies for a reliable,
reusable, unmanned space test platform for the U.S. Space Force," according to a
fact sheet issued by Schriever Air Force Base in Colorado.
"The mission of Delta 9 is to prepare, present, and project assigned and attached
forces for the purpose of conducting protect and defend operations and providing
national decision authorities with response options to deter and, when necessary,
defeat orbital threats," the fact sheet explains. "Additionally, Delta 9 supports Space
Domain Awareness by conducting space-based battlespace characterization
operations and also conducts on-orbit experimentation and technology
demonstrations for the U.S. Space Force."
          """),
      const Article(
          assetName: 'images/10th.webp',
          title:
              "Mars was always too small to hold onto its oceans, rivers and lakes",
          description:
              "Mars' story may hold a basic truth about planetary habitability. Mars was doomed to desiccation by its small size, a new study suggests.",
          content:
              """Thanks to observations by robotic explorers such as NASA's Curiosity and 
Perseverance rovers, scientists know that in the ancient past, liquid water coursed
across the Martian surface: The Red Planet once hosted lakes, rivers and streams,
and possibly even a huge ocean that covered much of its northern hemisphere.
But that surface water was pretty much all gone by about 3.5 billion years ago, lost to
space along with much of the Martian atmosphere. This dramatic climate shift occurred
after the Red Planet lost its global magnetic field, which had protected Mars' air from being
stripped away by charged particles streaming from the sun, scientists believe.
But this proximate cause was underlain by a more fundamental driver, according to
the new study: Mars is just too small to hold onto surface water over the long haul.
"Mars' fate was decided from the beginning," study co-author Kun Wang, an
assistant professor of Earth and planetary sciences at Washington University in St.
Louis, said in a statement. "There is likely a threshold on the size requirements of
rocky planets to retain enough water to enable habitability and plate tectonics."
That threshold is larger than Mars, the scientists believe
The study team — led by Zhen Tian, a grad student in Wang's lab — examined 20 Mars
meteorites, which they selected to be representative of the Red Planet's bulk composition.
The researchers measured the abundance of various isotopes of potassium in these
extraterrestrial rocks, which ranged in age from 200 million years to four billion years.
(Isotopes are versions of an element thatcontain different numbers of neutrons in their
atomic nuclei.)
Tian and her colleagues used potassium, known by the chemical symbol K, as a tracer for
more "volatile" elements and compounds — stuff like water, which transitions to the gas
phase at relatively low temperatures. They found that Mars lost significantly more volatiles
during its formation than Earth, which is about nine times more massive than the Red
Planet. But Mars held onto its volatiles better than did Earth's moon and the 329-mile-wide
(530 kilometers) asteroid Vesta, both of which are much smaller and drier than the Red 
Planet.
"The reason for far lower abundances of volatile elements and their compounds in
differentiated planets than in primitive undifferentiated meteorites has been a
longstanding question," co-author Katharina Lodders, a research professor of Earth and
planetary sciences at Washington University, said in the same statement. ("Differentiated"
refers to a cosmic body whose interior has separated into different layers, such as crust,
mantle and core.)
"The finding of the correlation of K isotopic compositions with planet gravity is a novel
discovery with important quantitative implications for when and how the differentiated
planets received and lost their volatiles," Lodders said.
The new study, which was published online today (Sept. 20) in the journal Proceedings of
the National Academies of Sciences, and previous work together suggest that small size is a
double whammy for habitability. Bantam planets lose lots of water during formation, and
their global magnetic fields also shut down relatively early, resulting in atmospheric
thinning. (In contrast, Earth's global magnetic field is still going strong, powered by a
dynamo deep within our planet.)
The new work also could have applications beyond our own cosmic backyard, team
members said.
"This study emphasizes that there is a very limited size range for planets to have
just enough but not too much water to develop a habitable surface environment,"
co-author Klaus Mezger, of the Center for Space and Habitability at the University of
Bern in Switzerland, said in the same statement. "These results will guide
astronomers in their search for habitable exoplanets in other solar systems."
That "surface environment" disclaimer is an important one in any discussion of
habitability. Scientists think that modern Mars still supports potentially lifesupporting underground aquifers, for example. And moons such as Jupiter's Europa
 and Saturn's Enceladus host huge, possibly life-supporting oceans beneath their
ice-covered surfaces.
          """),
      const Article(
          assetName: 'images/11th.webp',
          title:
              "NASA's Perseverance rover has taken the 1st steps in decades-long dream of Mars sample return",
          description:
              "Perseverance's Mars rock samples may even hide salt crystal time capsules.",
          content:
              """NASA's Perseverance rover on Mars has begun its out-of-this-world rock collection.
The rover, which is designed to search for signs of ancient life on Mars and to
package up material for a future sample-return mission, made its first two successful
sampling maneuvers on Monday and Wednesday (Sept. 6 and Sept. 8). NASA
scientists describing the collection said they're thrilled with what they know so far
about the two rock cores.
"This is a truly historic achievement, the very first rock cores collected on another
terrestrial planet — it's amazing," Meenakshi Wadhwa, Mars sample return
principal scientist, at NASA's Jet Propulsion Laboratory (JPL) in California and Arizona
State University, said during a news conference held Friday (Sept. 10).
"In our science community, we've talked about Mars sample return for decades,
and now it's actually starting to feel real," Wadhwa added. "These first core samples
will actually be among tens of other samples that will be collected by the
Perseverance rover."
This week's successes came after an initial sampling attempt a month prior didn't go
quite according to plan. On Aug. 6, the Perseverance rover drilled into a carefully
selected rock, but failed to cache a rock core. Scientists troubleshooting the issue
determined that the rock was unexpectedly crumbly, foiling the rover's sampling
mechanism.
At that point, the mission team's top priority was to confirm that the sampling
mechanism was working properly. After analyzing the initial failure, Perseverance
personnel pointed the rover to a new target that appeared to be less weathered
and more robust, Jessica Samuels, the Perseverance surface mission manager at
JPL, said during the news conference.
And the rover team's second rock selection, nicknamed "Rochette," proved more
amenable to Perseverance's equipment. In the meantime, the engineers'
excitement had spilled over to the geologists on the team. "As we were evaluating 
this target, the science team found this target to be of very high value as well,"
Samuels said.
As a result, the mission team decided to attempt to collect not one but two samples
of Rochette, which the team is now referring to as "Montdenier" and "Montagnac."
Perseverance is equipped with 43 sample tubes, and because the rover will set up
one or more stores of tubes during its mission, scientists have budgeted for taking
multiple cores of rocks that they want to be positive can make it back to Earth,
Perseverance deputy scientist Katie Stack Morgan of JPL said during the news
conference.
Because of the previous sampling misfire, Perseverance's human directors had the
robot take extra photographs before attempting to store the first sample,
Montdenier, adding to the uncertainty.
"We were rewarded for our patience," Matt Robinson, Perseverance strategic
sampling operations team chief at JPL, said during the news conference, sharing an
image. "Looking down the drill bit into the tube, you see a beautiful core there. At
that point, our team was just absolutely ecstatic. I don't have words to say how we
felt."
The scientists are ecstatic, too, of course. Both of the new samples come from the
same boulder within Jezero Crater, where the rover is exploring terrain that long
ago hosted a lake. That rock is likely relatively young, and so far, scientists have
determined that that rock is basaltic, which means it may represent cooled lava that
flowed along the Red Planet's surface. In addition, Perseverance has detected salt
in the two cores.
These compounds could have formed from groundwater flowing through the rock
or surface water evaporating away, according to a NASA statement. In addition, the
salt might have locked away tiny bubbles of water as the crystal formed, according
to the statement, which scientists may eventually be able to study as a sort of time
capsule within the rock.
Since landing on the Red Planet in February, the Perseverance rover has spent nearly 200
Martian days (a little more than 200 Earth days) on the surface and has traveled about 1.4
miles (2.2 kilometers), Samuels said. However, because of Mars solar conjunction, when the
sun comes between Earth and Mars and makes communication with the Red Planet
difficult, Perseverance and the rest of NASA's Mars fleet will pause work for several weeks
beginning by early October, according to NASA.
But even as the humans behind Perseverance celebrate the two new samples and
prepare for a science hiatus, they are also planning the rover's next moves.
Perseverance is headed to a region scientists are calling South Séítah, which the
rover's airborne companion, the Ingenuity helicopter, has been scouting out on
reconnaissance flights. Mission scientists are intrigued by the region's rugged
landscape of ridges, sand dunes and rock shards, and the rock here is likely older
than Rochette, according to NASA.
The mission hopes to spend its time on Mars laying the groundwork for a future
multispacecraft mission that NASA and the European Space Agency have begun developing
to bring scientists their first pristine pieces of the Red Planet, perhaps by 2031. The sample
collection is a milestone for not just Perseverance, but the agency's Mars program writ
broad, Lori Glaze, the head of NASA's Planetary Science Division, said during the news
conference.
And Perseverance also looks back, building on NASA's decades of experience exploring
Mars, she emphasized. "Everything we do builds on what we've learned before," Glaze said.
"We stand on the shoulders of the giants to be where we are today."
          """),
      const Article(
          assetName: 'images/12th.webp',
          title:
              "Skywatchers see SpaceX's Dragon cargo ship streak across the night sky as it returned to Earth",
          description:
              "The cargo ship made a sonic boom over Florida and Georgia as it glided toward the Atlantic Ocean.",
          content:
              """Late Thursday night (Sept. 30) in the southeastern United States, anybody looking
up could have glimpsed a brilliant streak, trailing down into the Atlantic Ocean off
Florida's east coast. It was actually a SpaceX Dragon cargo resupply spacecraft 
returning to Earth after a trip to the International Space Station (ISS).
The Dragon, which flew to the ISS as part of SpaceX's 23rd cargo resupply mission
for NASA (CRS-23), had been in space since August. It went to the ISS carrying
several tons of supplies, equipment and science experiments for the Expedition 65
crew. Those experiments included a student project from Hasselt University in
Belgium and the island country of Malta's first­ever contribution to the ISS: probing
the microbes inside the skin of foot ulcers.
"""),
      const Article(
          assetName: 'images/13th.jpg',
          title: "A space fan's guide to New York Comic Con 2021",
          description: "Many of this year's events will be held in person.",
          content:
              """This year's New York Comic Con is a little different. Unlike last year, when the event was
completely virtual, this year's event is a tentative step towards restoring normality. There
are still some virtual events — that's probably going to be a permanent addition to
conventions — but this year the annual sci-fi convention in-person panels — and that's
awesome
That said, there will be strict procedures in place. To gain entry, proof of vaccination
is mandatory for anyone over the age of 12 and anyone under that age must
provide proof of a negative COVID-19 test. There will probably be plastic guards in
place at the photo booths too, so be prepared. And it goes without saying that a
mask must be worn at all times. You can read more about the health and safety 
policies here. 
To ensure you don't miss a thing, we've scanned the schedule, analyzed the sensor
readings and pulled out the can't-miss panels that you should make your top
priority. Events will also be shown live on the NYCC YouTube channel."""),
      const Article(
          assetName: 'images/14th.webp',
          title:
              "Best telescopes 2021: Top picks for beginners, viewing planets, astrophotography and all-arounders",
          description:
              "Whatever your budget, experience in astronomy or targets that interest you most, there’s a great telescope out there just for you",
          content:
              """Whatever your budget, experience in astronomy or targets that
interest you most, there’s a great telescope out there just for you
— we’ve rounded up the very best
Buying the best telescope that fits your needs without leaving a dent in your
finances is a balancing act. If you're looking to buy a telescope for the summer for
some nighttime stargazing, here's some things to consider.
You can choose the telescope that does the most and with the highest price, but
these can be overly complex for a beginner. Of course, the other extreme is that
you spend so little on your telescope that you end up with a useless toy. 
A good starting point is to know how much you want to spend and what you find
most exciting about skywatching: is it seeing the planets up close, peering into deep
space at galaxies and nebulas, dabbling in astrophotography or a bit of everything?
It's also worth considering if an interest in observing or photography is going to
stay with you for a good amount of time — if you're not sure, binoculars could be a
great choice for you instead. 
We have selected the very best telescopes for beginners, viewing the planets,
astrophotography and all-arounders for a variety of budgets and from top manufacturers 
like Celestron, Sky-Watcher, Meade Instruments and Orion.
Orion SkyScanner 100 Reflector
Optical design: Reflector | Mount type: Dobsonian (desktop version) | Aperture: 
3.94" (100 mm) | Focal length: 15.75" (400 mm) | Highest useful magnification: 
200x | Lowest useful magnification: 14x | Supplied eyepieces: 10 mm, 20 mm | 
Weight: 6.17 lbs. (2.8 kg) (desktop version)
Compact and easy to use
Bright, sharp views
Assembled out of the box
Desktop, not all versions have tripod
A decent-sized aperture and good quality optics for the price, the Orion SkyScanner
100 is set-up to make astronomy easy for the beginner. You’ll be able to get very
good views of the planets, the moon, nebulas and the brighter galaxies, and the f/4
focal ratio ensures bright images of the targets you choose to observe. 
Also in the box is Starry Night software to help you choose your targets and pinpoint
them in the night sky. Two eyepieces — a 20 mm and 10 mm — is supplied with the
telescope, providing magnifications of 20x and 40x.
For a beginner's telescope, the sights were breathtaking and boast clarity and
contrast. The surface of the moon and Saturn's rings are particular highlights,
although due to the wide field of view, it is worth remembering that targets will be
small through the eyepiece. The same is said of "faint fuzzies" like the Andromeda 
Galaxy (Messier 31), which appear as bright patches of light even under a degree of
light pollution.
The Orion SkyScanner 100 employs a sturdy desktop mount, which swings along
the axes of altitude and azimuth, so skywatchers will need to ensure that they use a
sturdy table for steady observations of the night sky. Slewing is a very smooth
process with this telescope, with some models of the SkyScanner 100 offering a
tripod.
Orion has supplied a clear manual that explains how to use the reflector as well as
attach and calibrate the EZ Finder II red dot finder. However, given that the
telescope comes assembled straight out of the box, it's unlikely the skywatcher will
struggle with assembling and using it.
Celestron StarSense Explorer LT 114AZ
Type: Reflector | Mount type: Alt-azimuth | Aperture: 4.49" (114 mm) | Focal 
length: 39.37" (1,000 mm) | Highest useful magnification: 269x | Lowest useful 
magnification: 16x | Supplied eyepieces: 10 mm, 25 mm | Weight: 10.41 lbs. (4.72
kg)
Simple to set up and align
Good intro to astrophotography
Suggests targets to observe
Lacks computerized mount
While a great telescope for beginners, the Celestron StarSense Explorer LT 114 can
be enjoyed by intermediate skywatchers, too — especially those who want to spend
less time setting up and more time observing. Assembly takes less than 20 minutes.
Built into this reflector is Celestron’s StarSense technology, which provides an easy
option for aligning the telescope and enables the onboard GoTo system to work out
which direction the instrument is pointing. To use the tech, all the skywatcher
needs to do is download the StarSense app and take a smartphone image through
the eyepiece and the app works out which stars are in the telescope's field of view
to calculate the astronomer's orientation. 
Moving to Jupiter, we made use of the 10 mm eyepiece to view the gas giant. Views
are clear, but you'll need a selection of eyepieces and filters in order to pick out the
coloration of the atmospheric bands. The planet's largest moons are visible as
clear, sharp points of light. Views of the moon, Venus and the Beehive Cluster
(Messier 44) are also pleasing, with good clarity.
The beauty of the Celestron StarSense series is that you can read up on the
literature offered by the app for each target you observe. Slewing from one target
to another, we found that the StarSense Explorer LT 114 is a sturdy piece of kit and
operates smoothly. One minor drawback is that skywatchers need to manually
push the telescope as a motorized mount is not supplied.
With a fair-sized aperture and quality optics typical of Celestron products, you’ll be
hard-pressed to find a beginner's telescope as good and easy to use for the same
price."""),
      const Article(
          assetName: 'images/15th.jpg',
          title: "8 Cool Destinations That Future Mars Tourists Could Explore",
          description:
              "Mars is a planet of vast contrasts — huge volcanoes, deep canyons, and craters that may or may not host running water.",
          content:
              """Mars is a planet of vast contrasts — huge volcanoes, deep canyons, and craters that may or
may not host running water. It will be an amazing location for future tourists to explore,
once we put the first Red Planet colonies into motion. The landing sites for these future
missions will likely need to be flat plains for safety and practical reasons, but perhaps they
could land within a few days' drive of some more interesting geology. Here are some
locations that future Martians could visit.
Olympus Mons
Olympus Mons is the most extreme volcano in the solar system. Located in the Tharsis
volcanic region, it's about the same size as the state of Arizona, according to NASA. Its
height of 16 miles (25 kilometers) makes it nearly three times the height of Earth's Mount
Everest, which is about 5.5 miles (8.9 km) high.
Olympus Mons is a gigantic shield volcano, which was formed after lava slowly crawled
down its slopes. This means that the mountain is probably easy for future explorers to
climb, as its average slope is only 5 percent. At its summit is a spectacular depression some
53 miles (85 km) wide, formed by magma chambers that lost lava (likely during an eruption)
and collapsed.
Tharsis volcanoes
While you're climbing around Olympus Mons, it's worth sticking around to look at some of the
other volcanoes in the Tharsis region. Tharsis hosts 12 gigantic volcanoes in a zone roughly
2500 miles (4000 km) wide, according to NASA. Like Olympus Mons, these volcanoes tend 
to be much larger than those on Earth, presumably because Mars has a weaker
gravitational pull that allows the volcanoes to grow taller. These volcanoes may have
erupted for as long as two billion years, or half of the history of Mars.
The picture here shows the eastern Tharsis region, as imaged by Viking 1 in 1980. At left,
from top to bottom, you can see three shield volcanoes that are roughly 16 miles (25 km)
high: Ascraeus Mons, Pavonis Mons, and Arsia Mons. At upper right is another shield
volcano called Tharsis Tholus.
Valles Marineris
Mars not only hosts the largest volcano of the solar system, but also the largest canyon. Valles
Marineris is roughly 1850 miles (3000 km) long, according to NASA. That's about four times
longer than the Grand Canyon, which has a length of about 500 miles (800 km).
Researchers aren't sure how Valles Marineris came to be, but there are several theories
about its formation. Many scientists suggest that when the Tharsis region was formed, it
contributed to the growth of Valles Marineris. Lava moving through the volcanic region
pushed the crust upward, which broke the crust into fractures in other regions. Over time,
these fractures grew into Valles Marineris.
The North and South Poles
Mars has two icy regions at its poles, with slightly different compositions; the north pole
(pictured) was studied up close by the Phoenix lander in 2008, while our south pole
observations come from orbiters. During the winter, according to NASA, temperatures near
both the north and south poles are so frigid that carbon dioxide condenses out of the
atmosphere into ice, on the surface.
The process reverses in the summer, when the carbon dioxide sublimates back into the
atmosphere. The carbon dioxide completely disappears in the northern hemisphere,
leaving behind a water ice cap. But some of the carbon dioxide ice remains in the southern
atmosphere. All of this ice movement has vast effects on the Martian climate, producing
winds and other effects
Gale Crater and Mount Sharp (Aeolis Mons)
Made famous by the landing of the Curiosity rover in 2012, Gale Crater is host to extensive
evidence of past water. Curiosity stumbled upon a streambed within weeks of landing, and
found more extensive evidence of water throughout its journey along the crater floor.
Curiosity is now summiting a nearby volcano called Mount Sharp (Aeolis Mons) and looking
at the geological features in each of its strata.
One of Curiosity's more exciting finds was discovering complex organic molecules in the
region, on multiple occasions. Results from 2018 announced these organics were
discovered inside of 3.5-billion-year-old rocks. Simultaneous to the organics results,
researchers announced the rover also found methane concentrations in the atmosphere
change over the seasons. Methane is an element that can be produced by microbes, as
well as geological phenomena, so it's unclear if that's a sign of life
Medusae Fossae
Medusae Fossae is one of the weirdest locations on Mars, with some people even speculating
that it holds evidence of some sort of a UFO crash. The more likely explanation is it is a
huge volcanic deposit, some one-fifth of the size of the United States. Over time, winds
sculpted the rocks into some beautiful formations.But researchers will need more study to
learn how these volcanoes formed Medusae Fossae. A 2018 study suggested that the 
formation may have formed from immensely huge volcanic eruptions taking place
hundreds of times over 500 million years. These eruptions would have warmed the Red
Planet's climate as greenhouse gases from the volcanoes drifted into the atmosphere.
Recurring Slope Lineae in Hale Crater
Mars is host to strange features called recurring slope lineae, which tend to form on the sides
of steep craters during warm weather. It's hard to figure out what these RSL are, though.
Pictures shown here from Hale Crater (as well as other locations) show spots where
spectroscopy picked up signs of hydration. In 2015, NASA initially announced that the
hydrated salts must be signs of running water on the surface, but later research said the
RSL could be formed from atmospheric water or dry flows of sand.In reality, we may have
to get up close to these RSL to see what their true nature is. But there's a difficulty — if the
RSL indeed host alien microbes, we wouldn't want to get too close in case of
contamination. While NASA figures out how to investigate under its planetary protection
protocols, future human explorers may have to admire these mysterious features from
afar, using binoculars.
'Ghost Dunes' in Noctis Labyrinthus and Hellas basin
Mars is a planet mostly shaped by wind these days, since the water evaporated as its
atmosphere thinned. But we can see extensive evidence of past water, such as regions of
"ghost dunes" found in Noctis Labyrinthus and Hellas basin. Researchers say these regions
used to hold dunes that were tens of meters tall. Later, the dunes were flooded by lava or
water, which preserved their bases while the tops eroded away
Old dunes such as these show how winds used to flow on ancient Mars, which in turn gives
climatologists some hints as to the ancient environment of the Red Planet. In an even more
exciting twist, there could be microbes hiding in the sheltered areas of these dunes, safe 
from the radiation and wind that would otherwise sweep them away."""),
      const Article(
          assetName: 'images/16th.jpg',
          title:
              "Super Flower Blood Moon 2021: Where, when and how to see the supermoon lunar eclipse",
          description: "It's the only total lunar eclipse of 2021",
          content:
              """On the night of May 25-27, observers in Oceania, Hawaii, eastern Asia and Antarctica will
see a lunar eclipse that coincides with the moon's closest approach to Earth — making it a
"supermoon" eclipse that will turn the moon reddish — also known as a "blood moon."
(The dates of this eclipse span two days because the area it will be visible spans the
international date line). 
Lunar eclipses occur when the moon is on the opposite side of the Earth as the sun.
Usually we see a full moon when this happens, but every so often the moon enters the
Earth's shadow, resulting in an eclipse. This doesn't happen every full moon because the
plane of the moon's orbit is tilted about 5 degrees from the plane of the Earth's orbit, and
the moon "misses" the shadow of the Earth. 
Unlike a solar eclipse, which is only visible along a narrow track, lunar eclipses are visible
from the entire night side of the Earth; this entire eclipse takes about five hours from start
to finish. The timing depends a lot on what time zone you are in, relative to what is called
Universal Coordinated Time (effectively the hour in Greenwich, England). In Asia, the eclipse
occurs near moonrise in the evening. On the west coast of the Americas, the eclipse 
happens in the early morning hours, near moonset. The best viewing will be in between
those two extremes: Australia, New Zealand, Hawaii, the islands of the South Pacific and
southwestern Alaska. 
This lunar eclipse will appear slightly larger than normal because the moon will reach
perigee, the closest point in its orbit to Earth, on May 25 at 9:21 p.m. EDT (0121 May 26
GMT), some 14 hours after it is officially at full phase (which happens at 7:13 a.m. EDT, or
1113 GMT).
When the full moon and perigee are close, it is called a "supermoon" — though definitions
aren't consistent as it isn't an astronomical term. Ordinarily the moon is an average of
240,000 miles (384,500 kilometers) from Earth, but its orbit isn't perfectly circular. So the
distance varies slightly. When it reaches perigee this month, the moon will be 222,022 miles
(357,311 km) from Earth, per Heavens-Above.com calculations. The moon does appear
slightly larger when it is closer, but the difference is small, and it takes a very observant
skywatcher to notice.
The eclipse starts at 4:47:39 a.m. EDT (08:47:39 GMT), according to NASA's Eclipse Page.
That's when the moon touches the penumbra. The partial phase of the eclipse starts about
57 minutes later, at 5:44 a.m. EDT (09:44:57 GMT). The moon enters the total phase of the
eclipse at 7:11:25 EDT (11:11:25 GMT) and completes exiting the umbra at 10:52:22 EDT
(12:52:22 GMT). Last contact is at 13:49:41. (To convert from GMT to your time zone you
can use this converter). 
In Asia, the westernmost locations to see the eclipse are in India, Sri Lanka, western China
and Mongolia, but only the penumbral phase will be visible. In Colombo, Sri Lanka for
example, the moon rises at 6:23 p.m. local time on May 26, and the penumbral eclipse
ends at 7:19 p.m. local time.
As one moves east more of the eclipse is visible. In Bangkok, the moon — which will
already be deep in the Earth's shadow, appearing reddish — rises at 6:38 p.m. local time
and the local maximum eclipse is three minutes later; the moon emerges from the umbra
at 7:52 p.m. local time, and the penumbral eclipse ends at 8:49 p.m. local time. 
From Tokyo, one can see the entire umbral phase of the eclipse just after moonrise at 6:37
p.m. local time. The moon will look slightly darker as the penumbral phase will have started
already, and the moon touches the umbra at 6:44 p.m. local time. At that point, the moon
will be turning red and just peeking over the horizon. The moon will be in the total phase of
the eclipse, completely red, at 8:11 p.m. and greatest eclipse is at 8:18 p.m. local time. The
total phase ends at 8:25 p.m. and the moon will leave the umbra at 9:52 p.m.; the eclipse
ends at 10:49 p.m. local time. 
The eastern two-thirds of Australia will see the entire eclipse. From Melbourne, the
penumbral eclipse starts at 6:47 p.m. Australian Eastern Standard Time and the moon is 
already about 18 degrees above the horizon. The partial phase starts at 7:44 p.m. AEST and
the total phase at 9:11 p.m. AEST. At that point, the moon is 45 degrees above the horizon
— well above most obstructions. The total eclipse ends at 9:25 p.m. AEST and the umbral
phase at 10:52 p.m. AEST. The penumbral phase ends near midnight, at 11:52 p.m. AEST.
For observers in the United States, the only places where the entire eclipse is visible are in
Hawaii or Alaska. The table below lists several cities from which the entire umbral phase of
the eclipse is visible, based on information from timeanddate.com and NASA's eclipse
page. The cities are listed from west to east. Dates are noted when they change if one
phase of the eclipse occurs after local midnight. Information is based on Time and Date.
The moon turns red because of the Earth's atmosphere. The atmosphere tends to
scatter blue light — it's one reason the sky appears blue from the ground. As the
Earth passes between the sun and moon, the light from the sun passes through the
Earth's atmosphere and the blue light is scattered. 
In addition, the light is refracted, or bent, and focused on the moon. In that sense,
the Earth's air is like a giant lens. The light hits the moon and is reflected back to us
— and we see the moon turn blood­red. From the point of view of a lunar observer,
the Earth would eclipse the sun and be surrounded by a red ring of refracted
sunlight. 
A lunar eclipse consists of six stages, the start of which are called "contacts." First
contact (marked as P1 on charts) is when the moon touches the penumbra of the
Earth. The penumbra is the part of the shadow that is lighter and only discolors the
moon somewhat (it generally looks brownish-gray, or tea-stained, but the exact hue
depends a lot on atmospheric conditions on Earth and one's own color perception).
If one were standing on the moon, at first contact one would see the Earth
approaching the sun but not quite blocking it yet — you'd see the dark side of the
Earth, though. 
Second contact is called U1, and that's when the moon touches the Earth's umbra —
this is the dark part of the Earth's shadow, and that's when one sees the moon get
a "bite" taken out of it. From the moon, one would see the Earth touching the sun,
and blocking its light. This is also called the partial phase of the eclipse since the
moon will be partially darkened. 
The next stage is third contact, U2, when the trailing edge of the moon touches the
edge of the umbra, this is the total phase of the eclipse. The moon is entirely within
the Earth's darkest shadow at this point and turns a dark reddish color. From the
moon, one would see the Earth completely covering the sun. Astronomers call this
totality or total phase. After that comes the moment of greatest eclipse, when the
moon is closest to the center of the umbra. 
Fourth contact is U3, when the leading side of the moon touches the umbra, and
the total phase of the eclipse ends. On the moon, you'd see the sun peek out from
behind the Earth. Fifth contact is U4, and that's when the moon emerges from
Earth's umbra. Finally, at sixth contact, P4, the moon emerges from the penumbra. 
This whole event can last up to several hours, depending on how deeply the moon enters
the Earth's shadow. 
n Mark Twain's story "A Connecticut Yankee in King Arthur's Court" the time-traveling
protagonist impresses King Arthur by his knowledge of the occurrence of a solar
eclipse. In reality that wouldn't likely fool anyone at the time — Ptolemy had already
worked out how to predict solar and lunar eclipses in 150 CE, some 300 to 400 years
prior to the legendary Arthur's existence. Babylonian and Chinese astronomers also
made sophisticated tables and calculations of eclipse timing as did the ancient
Maya. 
Lunar eclipses were easier to predict than solar eclipses because they are visible
from anywhere on the night side of Earth. So if you're thinking of time traveling and
bringing a lunar eclipse table to impress the natives, think again.
That said, eclipses were still seen as astrological agents of calamity; it's not uncommon to
see legends of various creatures attacking the moon. For example, the Mesopotamians
thought demons were attacking. Some cultures, such as the Hupa of northern California
saw the lunar eclipse as an act of injury (hence the blood-red color) and renewal (as the
moon healed and returned)"""),
      const Article(
          assetName: 'images/17th.jpg',
          title: "Star Wars movies ranked, worst to best",
          description:
              "From A New Hope to The Rise of Skywalker, here’s all the Star Wars movies ranked, worst to best. Now enjoy the greatest moments from a galaxy far, far away.",
          content:
              """Looking for all the Star Wars movies ranked, worst to best? Well, we’ve got you covered!
The Star Wars universe has grown exponentially over the last few years, and what started
out as an indie movie no one expected to do much back in 1977 has become a huge
cinematic universe. This now includes numerous movies spanning multiple time periods
and featuring many different characters. Good news if you’re a fan, but also a bit
problematic if you’re looking to rewatch them all
There’s been 12 Star Wars movies released so far – if you don’t count the straight to
TV classics, such as Caravan of Courage: An Ewok Adventure (which we don’t) – so, if
you’re sitting down to binge them all, you really don’t have time to watch the duds.
Many Star Wars movies are considered among the best space movies of all time, but
there’s still a fair few that you wouldn’t want to watch more than once. 
That’s where our helpful breakdown of all the Star Wars movies ranked comes in.
Follow our guide from the movies to miss, to the movies that cannot be missed, to 
ensure you’ve seen all the best bits of the Star Wars saga. And, if you’re still
jonesing for a midi-chlorian hit after you’ve read it, then don’t forget to check out
our best Star Wars LEGO sets too.
Let’s get the worst of the Star Wars movies out of the way as quickly as we can.
Trust us, it doesn’t get much worse than Attack of the Clones. The overreliance on
CGI sets, the numerous boring senate scenes, the awkward, supposedly ‘romantic’
conversations between Anakin and Padmé... need I go on? There’s so many reasons
why Attack of the Clones is one of the worst Star Wars movies, but most of them
can be boiled down to the fact that it suffers from the middle movie curse. 
We’ve seen it before with other trilogies, and although none of the Star Wars
prequel movies are particularly good, the first and the third movies at least knew
what they wanted to do. The middle movie, Attack of the Clones, tries to bridge the
gap between Anakin, the cute, innocent kid in Episode I, and the eventual baddie,
Darth Vader, in Episode III, and the fact of the matter is that the writing and Hayden
Christensen just weren’t up to the task."""),
    ];

class BlogItem extends StatelessWidget {
  const BlogItem({
    Key? key,
    required this.article,
  }) : super(key: key);

  // This height will allow for all the Card's content to fit comfortably within the card.
  static const height = 298.0;
  final Article article;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            SectionTitle(title: article.title),
            SizedBox(
              height: height,
              child: Card(
                // This ensures that the Card's children (including the ink splash) are clipped correctly.
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlogPage(
                          article: article,
                        ),
                      ),
                    );
                  },
                  // Generally, material cards use onSurface with 12% opacity for the pressed state.
                  splashColor:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.12),
                  // Generally, material cards do not have a highlight overlay.
                  highlightColor: Colors.transparent,
                  child: BlogContent(article: article),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 4, 4, 12),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(title, style: Theme.of(context).textTheme.subtitle1),
      ),
    );
  }
}

class BlogContent extends StatelessWidget {
  const BlogContent({Key? key, required this.article}) : super(key: key);

  final Article article;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final titleStyle = theme.textTheme.headline5!.copyWith(color: Colors.white);
    final descriptionStyle = theme.textTheme.subtitle1;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 140,
          child: Stack(
            children: [
              Positioned.fill(
                child: Ink.image(
                  image: AssetImage(
                    article.assetName,
                  ),
                  fit: BoxFit.cover,
                  child: Container(),
                ),
              ),
              Positioned(
                bottom: 16,
                left: 16,
                right: 16,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    article.title,
                    style: titleStyle,
                  ),
                ),
              ),
            ],
          ),
        ),
        // Description and share/explore buttons.
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: DefaultTextStyle(
            softWrap: false,
            overflow: TextOverflow.ellipsis,
            style: descriptionStyle!.copyWith(color: Colors.black54),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    article.description,
                    style: descriptionStyle.copyWith(color: Colors.black54),
                  ),
                ),
              ],
            ),
          ),
        ),
        // share, explore buttons
      ],
    );
  }
}

//individual blog page

class BlogPage extends StatefulWidget {
  const BlogPage({Key? key, required this.article}) : super(key: key);
  final Article article;
  @override
  _BlogPageState createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  bool selected = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.article.title),
        actions: [
          IconButton(
            icon: Icon(
              selected ? Icons.favorite : Icons.favorite_border,
              color: selected ? Colors.red : null,
              semanticLabel: selected ? 'Remove from saved' : 'Save',
            ),
            onPressed: () {
              setState(() {
                selected = !selected;
              });
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
                  child: ListTile(
                    title: Text(
                      widget.article.title,
                      style: const TextStyle(fontSize: 35),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Text(
                        widget.article.description,
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.6), fontSize: 16),
                      ),
                    ),
                  ),
                ),
                Image.asset('images/space.jpg'),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    widget.article.content,
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.6), fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//TODO: Create blog page
class CreateBlog extends StatelessWidget {
  const CreateBlog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const sizedBoxSpace = SizedBox(height: 24);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Blog"),
      ),
      body: Center(
        child: Form(
          child: Scrollbar(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  sizedBoxSpace,
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    textCapitalization: TextCapitalization.words,
                    decoration: const InputDecoration(
                      filled: true,
                      icon: Icon(Icons.person),
                      hintText: 'Enter your name',
                      labelText: 'Name',
                    ),
                  ),
                  sizedBoxSpace,
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    textCapitalization: TextCapitalization.words,
                    decoration: const InputDecoration(
                      filled: true,
                      icon: Icon(Icons.person),
                      hintText: 'Enter a blog title',
                      labelText: 'Title',
                    ),
                  ),
                  sizedBoxSpace,
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    textCapitalization: TextCapitalization.words,
                    decoration: const InputDecoration(
                      filled: true,
                      icon: Icon(Icons.person),
                      hintText: 'Enter a blog description',
                      labelText: 'Description',
                    ),
                  ),
                  sizedBoxSpace,
                  TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter the blog",
                      labelText: "Blog",
                    ),
                    maxLines: 3,
                  ),
                  sizedBoxSpace,
                  Center(
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Padding(
                        padding: EdgeInsets.all(16),
                        child: Text(
                          'Submit',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

QuizBrain quizBrain = QuizBrain();

class Quizes extends StatelessWidget {
  const Quizes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quiz"),
        actions: [
          PopupMenuButton<Text>(itemBuilder: (context) {
            return [
              PopupMenuItem(
                child: const Text("Restart"),
                onTap: () {
                  quizBrain.reset();
                  Navigator.pop(context);
                },
              ),
            ];
          })
        ],
      ),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: QuizPage(),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = [];

  void checkAnswer(bool userPickedAnswer) {
    bool correctAnswer = quizBrain.getCorrectAnswer();

    setState(() {
      if (userPickedAnswer == correctAnswer) {
        scoreKeeper.add(const Icon(
          Icons.check,
          color: Colors.green,
        ));
      } else {
        scoreKeeper.add(const Icon(
          Icons.close,
          color: Colors.red,
        ));
      }
      if (quizBrain.isFinished()) {
        Alert(
          context: context,
          title: 'Finished!',
          desc: 'You\'ve reached the end of the quiz.',
          buttons: [
            DialogButton(
              child: const Text(
                "Restart",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () {
                setState(() {
                  quizBrain.reset();
                  scoreKeeper = [];
                });
                Navigator.of(context, rootNavigator: true).pop();
              },
              width: 120,
            )
          ],
        ).show();
      } else {
        quizBrain.nextQuestion();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 25.0,
                  color: Colors.blue,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              child: const Text(
                'True',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                //The user picked true.
                checkAnswer(true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              child: const Text(
                'False',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                //The user picked true.
                checkAnswer(false);
              },
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        )
      ],
    );
  }
}
