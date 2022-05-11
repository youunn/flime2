#include <boost/algorithm/string/join.hpp>
#include <boost/regex.hpp>
#include <iostream>
#include <string>
#include <vector>

int hello() {
  std::vector<std::string> s;
  s.push_back("Hello");
  s.push_back("World");

  auto joined = boost::algorithm::join(s, ", ");
  std::cout << joined << std::endl;

  std::string pattern("e.*");
  boost::regex regex(pattern);

  boost::sregex_iterator it(s[0].begin(), s[0].end(), regex);
  boost::sregex_iterator end;
  for (; it != end; ++it) {
    std::cout << it->str() << std::endl;
  }

  return 0;
}
